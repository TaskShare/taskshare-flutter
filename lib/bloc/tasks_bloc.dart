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
      return ref
          .orderBy('${TaskProperties.dueTime}', descending: false);
      // bug: https://github.com/flutter/flutter/issues/15928
//          .orderBy(TaskProperties.createTime, descending: true);
    })
    .map((tasks) {
      tasks.sort((a, b) {
        final compareByCreate = () {
          return -a.createTime.compareTo(b.createTime);
        };
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
      });
      return tasks;
    })
        .pipe(tasks);
  }

  update(Task task) {
    final now = DateTime.now();
    if (task.createTime == null) {
      task.createTime = now;
    }
    task.updateTime = now;
    database.set(task);
  }

  delete(Task task) {
    database.delete(task);
  }

  // TODO: call
  dispose() {
    tasks.close();
  }
}
