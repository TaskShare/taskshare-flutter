import 'package:taskshare/export/export_model.dart';
import 'package:taskshare/model/group.dart';
import 'package:taskshare/model/task.dart';
export 'package:taskshare/model/task.dart';

class TasksBloc {
  final _firestore = Firestore.instance;
  final String groupName;
  Database<Task> database;
  final tasks = BehaviorSubject<List<Task>>();

  TasksBloc({@required this.groupName}) {
    database = AppDatabase(
        collectionRef: _firestore
            .collection(Group.entity)
            .document(groupName)
            .collection(Task.entity),
        encoder: TaskEncoder(),
        decoder: TaskDecoder());

    database.entities((ref) {
      return ref;
    }).pipe(tasks);
  }

  add(Task task) {
    database.set(task);
  }

  // TODO: call
  dispose() {
    tasks.close();
  }
}
