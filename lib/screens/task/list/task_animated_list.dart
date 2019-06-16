import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:observable/observable.dart';
import 'package:quiver/iterables.dart';
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
      // TODO(mono): Enhance diff algorithm
      final diffs = _differ.diff(_tasks, tasks);
      for (final diff in diffs) {
        diff.removed.forEach(remove);
        final added = diff.added.toList();
        for (final i in range(0, added.length).cast<int>()) {
          final task = added[i];
          final index = diff.index + i;
          _tasks.insert(index, task);
          _animatedList.insertItem(index);
        }
      }
    });
  }

  final GlobalKey<AnimatedListState> listKey;
  final ValueObservable<List<Task>> stream;
  final TaskRemovedItemBuilder removedItemBuilder;
  final List<Task> _tasks;
  final _differ = const ListDiffer<Task>();
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
