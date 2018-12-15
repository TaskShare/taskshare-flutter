import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/group.dart';
import 'package:taskshare/model/model.dart';
import 'package:taskshare/model/task.dart';

export 'package:taskshare/model/task.dart';

enum TaskOperationType { deleted, checked, add, updated }

class TaskOperation {
  final Task task;
  final TaskOperationType type;

  TaskOperation({
    @required this.task,
    @required this.type,
  });
}

class TasksBloc implements Bloc {
  ValueObservable<List<Task>> get tasks => _tasks.stream;
  Stream<TaskOperation> get taskOperations => _taskOperations.stream;

  Sink<TaskOperation> get taskOperation => _taskOperationController.sink;

  StreamSubscription<FirebaseUser> userSubscription;
  final Authenticator authenticator;
  final _firestore = Firestore.instance;
  String _groupName;
  Database<Task> _database;
  final _tasks = BehaviorSubject<List<Task>>();
  final _taskOperations = PublishSubject<TaskOperation>();
  final _taskOperationController = PublishSubject<TaskOperation>();
  final _pendingDoneIds = Set<String>();

  TasksBloc({@required this.authenticator}) {
    log.info('TasksBloc constructor called');

    userSubscription = authenticator.user.listen((user) {
      if (user == null) {
        log.info('same group name is null');
        _groupName = null;
        return;
      }
      final groupName = user.uid;
      if (_groupName == groupName) {
        log.info('same group name: $groupName');
        return;
      }
      _groupName = groupName;
      _database = AppDatabase(
          collectionRef: _firestore
              .collection(Group.entity)
              .document(groupName)
              .collection(Task.entity),
          encoder: TaskEncoder(),
          decoder: TaskDecoder());

      _database
          .entities((ref) => ref
              .orderBy('${TaskProperties.dueTime}', descending: false)
              .orderBy('${TaskProperties.createTime}', descending: true))
          .map((tasks) {
        // 更新時に、ローカルと同期完了で2回呼ばれる
        log.info('tasks updated');
        // bug workaround. see: https://github.com/flutter/flutter/issues/15928
        tasks.removeWhere((task) =>
            task.doneTime != null && !_pendingDoneIds.contains(task.id));
        return tasks;
      }).listen(_tasks.add);
    });

    _taskOperationController.stream
        .doOnData(_taskOperations.add)
        .listen((operation) async {
      final task = operation.task;
      switch (operation.type) {
        case TaskOperationType.checked:
          _pendingDoneIds.add(task.id);
          _setTask(task);
          await Future<void>.delayed(Duration(milliseconds: 1000));
          final tasks = _tasks.value;
          if (_pendingDoneIds.remove(task.id)) {
            tasks.removeWhere((t) => t.id == task.id);
            _tasks.add(tasks);
          }
          break;
        case TaskOperationType.updated:
          if (task.doneTime == null) {
            _pendingDoneIds.remove(task.id);
          }
          _setTask(task);
          break;
        case TaskOperationType.add:
          _setTask(task);
          break;
        case TaskOperationType.deleted:
          await _database.delete(task);
          break;
      }
    });
  }

  void _setTask(Task task) {
    final now = DateTime.now();
    task.createTime ??= now;
    task.updateTime = now;
    _database.set(task);
  }

  @override
  void dispose() {
    userSubscription.cancel();
    _taskOperations.close();
    _taskOperationController.close();
    _tasks.close();
  }
}
