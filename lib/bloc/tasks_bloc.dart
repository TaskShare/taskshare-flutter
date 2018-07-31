import 'package:taskshare/export/export_model.dart';
import 'package:taskshare/model/group.dart';
import 'package:taskshare/model/task.dart';
export 'package:taskshare/model/task.dart';

class TasksBloc {
  TasksBloc() {
    log.info('TasksBloc constructor called');

    _groupChangeController.stream.listen((groupName) {
      if (_groupName == groupName) {
        log.info('same group name: $groupName');
        return;
      }
      _groupName = groupName;
      database = AppDatabase(
          collectionRef: _firestore
              .collection(Group.entity)
              .document(groupName)
              .collection(Task.entity),
          encoder: TaskEncoder(),
          decoder: TaskDecoder());

      database
          .entities((ref) =>
              ref.orderBy('${TaskProperties.dueTime}', descending: false))
          .map((tasks) {
        tasks
          ..sort((a, b) {
            compareByCreate() => -a.createTime.compareTo(b.createTime);
            if (a.dueTime == null) {
              if (b.dueTime == null) {
                return compareByCreate();
              }
              return 1;
            }
            if (b.dueTime == null) {
              return -1;
            }
            final comparedByDue = a.dueTime.compareTo(b.dueTime);
            if (comparedByDue != 0) {
              return comparedByDue;
            }
            return compareByCreate();
          })
          ..removeWhere((task) =>
              task.doneTime != null &&
              task.updateTime.compareTo(task.doneTime) > 0);
        log.info('tasks: $tasks');
        return tasks;
      }).pipe(_tasks);
    });

    _taskUpdateController.stream.listen((task) {
      final now = DateTime.now();
      task.createTime ??= now;
      task.updateTime = now;
      database.set(task);
    });

    _taskDeletionController.stream.listen((task) {
      database.delete(task);
    });
  }
  final _firestore = Firestore.instance;
  String _groupName;
  Database<Task> database;
  final _tasks = BehaviorSubject<List<Task>>();
  final _groupChangeController = StreamController<String>();
  final _taskUpdateController = StreamController<Task>();
  final _taskDeletionController = StreamController<Task>();
  Stream<List<Task>> get tasks => _tasks.stream;
  Sink<String> get groupChanger => _groupChangeController.sink;
  Sink<Task> get taskUpdate => _taskUpdateController.sink;
  Sink<Task> get taskDeletion => _taskDeletionController.sink;

  // TODO: call
  dispose() {
    _groupChangeController.close();
    _taskUpdateController.close();
    _taskDeletionController.close();
    _tasks.close();
  }
}
