import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskshare/model/task.dart';
import 'package:taskshare/screens/task/tasks_bloc.dart';

import '../../../util/util.dart';

typedef TaskRemovedItemBuilder = Widget Function(
  Task task,
  BuildContext context,
  Animation<double> animation,
);

@immutable
class TaskAnimatedList {
  TaskAnimatedList({
    @required this.listKey,
    @required this.stream,
    @required this.removedItemBuilder,
  }) : _tasks = stream.value ?? [] {
    stream.listen((tasks) {
      // TODO: Enhance diff algorithm
      final taskIds = Set.from(tasks.map((x) => x.id));

      // TODO: 末尾から削除していく必要あり
      final taskIdsRemoved = _previousTaskIds.difference(taskIds);
      logger.info('taskIdsRemoved: $taskIdsRemoved');
      for (final id in taskIdsRemoved) {
        final task = _tasks.firstWhere((t) => t.id == id);
        remove(task);
      }

      // TODO: 先頭から追加していく必要あり
      final taskIdsAdded = taskIds.difference(_previousTaskIds);
      logger.info('taskIdsAdded: $taskIdsAdded');
      for (final id in taskIdsAdded) {
        final task = tasks.firstWhere((t) => t.id == id);
        final index = tasks.indexOf(task);
        _tasks.insert(index, task);
        _animatedList.insertItem(index);
      }
    });
  }

  final GlobalKey<AnimatedListState> listKey;
  final ValueObservable<List<Task>> stream;
  final TaskRemovedItemBuilder removedItemBuilder;
  final List<Task> _tasks;
  Set<String> get _previousTaskIds => Set.from(_tasks.map((x) => x.id));
  int get length => _tasks.length;
  Task operator [](int index) => _tasks[index];

  AnimatedListState get _animatedList => listKey.currentState;

  void remove(Task task, {bool skipAnimation = false}) {
    final index = _tasks.indexOf(task);
    logger.info('index: $index');
    _tasks.removeAt(index);
    _animatedList.removeItem(index, (context, animation) {
      return removedItemBuilder(task, context, animation);
    }, duration: Duration(milliseconds: skipAnimation ? 0 : 500));
  }
}
