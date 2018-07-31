import 'package:taskshare/export/export_model.dart';

class Task implements Entity {
  static const entity = 'tasks';
  @override
  final String id;
  final String title;
  DateTime doneTime;
  DateTime dueTime;
  DateTime createTime;
  DateTime updateTime;

  Task(
      {@required this.id,
      @required this.title,
      this.doneTime,
      this.dueTime,
      this.createTime,
      this.updateTime});

  // MEMO: == はid比較だけにするべきかも？
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          doneTime == other.doneTime &&
          dueTime == other.dueTime &&
          createTime == other.createTime &&
          updateTime == other.updateTime;

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
        id: data[Entity.idKey],
        title: data[TaskProperties.title],
        doneTime: data[TaskProperties.doneTime],
        dueTime: data[TaskProperties.dueTime],
        createTime: data[TaskProperties.createTime],
        updateTime: data[TaskProperties.updateTime],
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
