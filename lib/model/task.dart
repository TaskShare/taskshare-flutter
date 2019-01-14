import 'package:taskshare/model/model.dart';

class Task implements Entity {
  static const name = 'tasks';
  @override
  final String id;
  final String title;
  Timestamp doneTime;
  Timestamp dueTime;
  Timestamp createTime;
  Timestamp updateTime;

  Task(
      {@required this.id,
      @required this.title,
      this.doneTime,
      this.dueTime,
      this.createTime,
      this.updateTime});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Task && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() => '''

Task{
  id: $id, 
  title: $title, 
  doneTime: $doneTime, 
  dueTime: $dueTime, 
  createTime: $createTime, 
  updateTime: $updateTime
}''';
}

class TaskEncoder extends SnapshotEncoder<Task> {
  @override
  Map<String, dynamic> encode(Task entity) => {
        Entity.idKey: entity.id,
        TaskProperties.title: entity.title,
        TaskProperties.doneTime: entity.doneTime,
        TaskProperties.dueTime: entity.dueTime,
        TaskProperties.createTime: entity.createTime,
        TaskProperties.updateTime: entity.updateTime
      };
}

class TaskDecoder extends SnapshotDecoder<Task> {
  @override
  Task decode(Map<String, dynamic> data) => Task(
        id: data[Entity.idKey] as String,
        title: data[TaskProperties.title] as String,
        doneTime: data[TaskProperties.doneTime] as Timestamp,
        dueTime: data[TaskProperties.dueTime] as Timestamp,
        createTime: data[TaskProperties.createTime] as Timestamp,
        updateTime: data[TaskProperties.updateTime] as Timestamp,
      );
}

// 'dart:mirrors'がDart 2では未実装なので
class TaskProperties {
  static const title = 'title';
  static const doneTime = 'doneTime';
  static const dueTime = 'dueTime';
  static const createTime = 'createTime';
  static const updateTime = 'updateTime';
}
