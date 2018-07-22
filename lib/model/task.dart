import 'package:taskshare/export/export_model.dart';

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
