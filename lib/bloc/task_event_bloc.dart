import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskshare/model/task.dart';

enum TaskEvent { dismissed, checkChanged }

class TaskEventContainer {
  final Task task;
  final TaskEvent event;
  final bool isChecked;

  TaskEventContainer({
    @required this.task,
    @required this.event,
    this.isChecked,
  });
}

class TaskEventBloc implements Bloc {
  TaskEventBloc() {
    _taskEventSinkController.pipe(_taskEventsController);
  }

  final _taskEventsController =
      StreamController<TaskEventContainer>.broadcast();
  final _taskEventSinkController = PublishSubject<TaskEventContainer>();

  Stream<TaskEventContainer> get events => _taskEventsController.stream;
  Sink<TaskEventContainer> get eventOccurred => _taskEventSinkController.sink;

  @override
  void dispose() {
    _taskEventsController.close();
    _taskEventSinkController.close();
  }
}
