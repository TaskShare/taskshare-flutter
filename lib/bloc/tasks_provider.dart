import 'package:flutter/material.dart';
import 'package:taskshare/lib.dart';
import 'tasks_bloc.dart';
export 'tasks_bloc.dart';

class TasksProvider extends InheritedWidget {
  final TasksBloc bloc;
  TasksProvider({
    @required Widget child,
    @required this.bloc,
    Key key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(TasksProvider oldWidget) => oldWidget.bloc != bloc;

  static TasksBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(TasksProvider) as TasksProvider)
          .bloc;
}
