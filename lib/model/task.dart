import 'package:taskshare/export/export_model.dart';

class Task implements Entity {
  static final entity = 'tasks';
  final String id;
  final String title;

  Task({
    @required this.id,
    @required this.title,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

class TaskEncoder extends SnapshotEncoder<Task> {
  @override
  Map<String, dynamic> encode(Task entity) {
    return {
      'id': entity.id,
      'title': entity.title,
    };
  }
}

class TaskDecoder extends SnapshotDecoder<Task> {
  @override
  Task decode(Map<String, dynamic> data) {
    return Task(id: data['id'], title: data['title']);
  }
}
