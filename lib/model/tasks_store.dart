import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskshare/model/group.dart';
import 'package:taskshare/model/model.dart';
import 'package:taskshare/model/task.dart';

abstract class TasksStore {
  void updateGroup(String groupName);
  String get groupName;
  Stream<List<Task>> get tasks;

  void set(Task task);
  void delete(Task task);
}

class TasksStoreFlutter implements TasksStore {
  final _firestore = Firestore.instance;
  Database<Task> _database;
  String _groupName;
  Stream<List<Task>> _tasks;

  @override
  void updateGroup(String groupName) {
    if (_groupName == groupName) {
      return;
    }
    _groupName = groupName;
    if (groupName == null) {
      return;
    }
    logger.info('groupName updated: $groupName');
    _database = AppDatabase<Task>(
        collectionRef: _firestore
            .collection(Group.name)
            .document(groupName)
            .collection(Task.name),
        encoder: TaskEncoder(),
        decoder: TaskDecoder());

    _tasks = _database.entities((ref) => ref
        .where('${TaskProperties.doneTime}', isNull: true)
        .orderBy('${TaskProperties.dueTime}', descending: false)
        .orderBy('${TaskProperties.createTime}', descending: true));
  }

  @override
  void set(Task task) {
    _database.set(task);
  }

  @override
  void delete(Task task) {
    _database.delete(task);
  }

  @override
  String get groupName => _groupName;

  @override
  Stream<List<Task>> get tasks => _tasks;
}
