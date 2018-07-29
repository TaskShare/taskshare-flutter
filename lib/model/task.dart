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
  Task decode(String documentID, Map<String, dynamic> data) {
    return Task(id: documentID, title: data['title']);
  }
}
