import 'dart:async';
import 'package:meta/meta.dart';
import 'package:taskshare/model/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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

  add(Task task) async {
    await database.set(task);
  }

  // TODO: call
  dispose() {
    tasks.close();
  }
}
