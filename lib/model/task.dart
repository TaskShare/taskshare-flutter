import 'package:taskshare/export/export_model.dart';

class Task implements Entity {
  static final entity = 'tasks';
  final String id;
  final String title;
  bool done;
  DateTime dueTime;
  DateTime createTime;
  DateTime updateTime;

  Task(
      {@required this.id,
      @required this.title,
        this.done = false,
      this.dueTime,
      this.createTime,
      this.updateTime});

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
      Entity.idKey: entity.id,
      TaskProperties.title: entity.title,
      TaskProperties.done: entity.done,
      TaskProperties.dueTime: entity.dueTime,
      TaskProperties.createTime: entity.createTime,
      TaskProperties.updateTime: entity.updateTime
    };
  }
}

class TaskDecoder extends SnapshotDecoder<Task> {
  @override
  Task decode(Map<String, dynamic> data) {
    return Task(
      id: data[Entity.idKey],
      title: data[TaskProperties.title],
      done: data[TaskProperties.done],
      dueTime: data[TaskProperties.dueTime],
      createTime: data[TaskProperties.createTime],
      updateTime: data[TaskProperties.updateTime],
    );
  }
}

// 'dart:mirrors'がDart 2では未実装なので
class TaskProperties {
  static final title = 'title';
  static final done = 'done';
  static final dueTime = 'dueTime';
  static final createTime = 'createTime';
  static final updateTime = 'updateTime';
}
