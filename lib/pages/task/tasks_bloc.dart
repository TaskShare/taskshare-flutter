import 'package:bloc_provider/bloc_provider.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/model.dart';
import 'package:taskshare/model/task.dart';
import 'package:taskshare/model/tasks_store.dart';
import 'package:taskshare/util/logger.dart';

export 'package:taskshare/model/task.dart';

enum TaskOperationType { deleted, checked, add, updated }

class TaskOperation {
  TaskOperation({
    @required this.task,
    @required this.type,
  });
  final Task task;
  final TaskOperationType type;
}

class TasksBloc implements Bloc {
  TasksBloc({@required this.authenticator, @required this.store}) {
    logger.info('TasksBloc constructor called');

    _subscription = authenticator.user.flatMap<List<Task>>((user) {
      final groupName = user?.id;
      if (user == null) {
        logger.info('same group name is null');
        store.updateGroup(groupName);
        return Observable.just([]);
      }
      if (store.groupName == groupName) {
        logger.info('same group name: $groupName');
        return Observable.empty();
      }

      store.updateGroup(groupName);

      return store.tasks;
    }).listen(_tasks.add);

    _taskOperationController.stream
        .doOnData(_taskOperations.add)
        .listen((operation) async {
      final task = operation.task;
      switch (operation.type) {
        case TaskOperationType.checked:
        case TaskOperationType.updated:
        case TaskOperationType.add:
          _setTask(task);
          break;
        case TaskOperationType.deleted:
          store.delete(task);
          break;
      }
    });
  }

  ValueObservable<List<Task>> get tasks => _tasks.stream;
  Stream<TaskOperation> get taskOperations => _taskOperations.stream;

  Sink<TaskOperation> get taskOperation => _taskOperationController.sink;

  StreamSubscription _subscription;
  final Authenticator authenticator;
  final TasksStore store;
  final _tasks = BehaviorSubject<List<Task>>();
  final _taskOperations = PublishSubject<TaskOperation>();
  final _taskOperationController = PublishSubject<TaskOperation>();

  void _setTask(Task task) {
    final now = Timestamp.now();
    task.createTime ??= now;
    task.updateTime = now;
    store.set(task);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _taskOperations.close();
    _taskOperationController.close();
    _tasks.close();
  }
}
