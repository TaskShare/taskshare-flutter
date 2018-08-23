import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/bloc/BlocProvider.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/group.dart';
import 'package:taskshare/model/model.dart';
import 'package:taskshare/model/task.dart';

export 'package:taskshare/model/task.dart';

class TasksBloc implements BlocBase {
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
          .entities((ref) =>
              ref.orderBy('${TaskProperties.dueTime}', descending: false))
          .map((tasks) {
        log.info('tasks updated');
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
        return tasks;
      }).listen(_tasks.add);
    });

    _taskUpdateController.stream.listen((task) {
      final now = DateTime.now();
      task.createTime ??= now;
      task.updateTime = now;
      _database.set(task);
    });

    _taskDeletionController.stream.listen((task) {
      _database.delete(task);
    });
  }

  Stream<List<Task>> get tasks => _tasks.stream;

  Sink<Task> get taskUpdate => _taskUpdateController.sink;

  Sink<Task> get taskDeletion => _taskDeletionController.sink;

  StreamSubscription<FirebaseUser> userSubscription;
  final Authenticator authenticator;
  final _firestore = Firestore.instance;
  String _groupName;
  Database<Task> _database;
  final _tasks = BehaviorSubject<List<Task>>();
  final _taskUpdateController = StreamController<Task>();
  final _taskDeletionController = StreamController<Task>();

  // TODO: call
  @override
  dispose() {
    userSubscription.cancel();
    _taskUpdateController.close();
    _taskDeletionController.close();
    _tasks.close();
  }
}
