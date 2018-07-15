import 'dart:async';
import 'package:meta/meta.dart';
import 'package:taskshare/model/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  static final entity = 'groups';
}

class Task extends Entity {
  static final entity = 'tasks';
  final String id;
  final String title;

  Task({
    @required this.id,
    @required this.title,
  }) : super(id: id);
}

class TaskEncoder extends SnapshotEncoder<Task> {
  @override
  Map<String, dynamic> encode(Task entity) {
    return {'title': entity.title};
  }
}

class TaskDecoder extends SnapshotDecoder<Task> {
  @override
  Task decode(DocumentSnapshot snap) {
    final data = snap.data;
    return Task(id: snap.documentID, title: data['title']);
  }
}

class TasksBloc {
  final _firestore = Firestore.instance;
  final String groupName;
  Database<Task> database;
  Stream<List<Task>> tasks;

  TasksBloc({@required this.groupName}) {
    database = AppDatabase(
        collectionRef: _firestore
            .collection(Group.entity)
            .document(groupName)
            .collection(Task.entity),
        encoder: TaskEncoder(),
        decoder: TaskDecoder());

    tasks = database.entities((ref) {
      return ref;
    });
  }

  add(Task task) async {
    await database.set(task);
  }
}
