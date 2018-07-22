import 'package:flutter/material.dart';
import 'package:taskshare/export/export.dart';
import 'tasks_bloc.dart';
export 'tasks_bloc.dart';

class TasksProvider extends InheritedWidget {
  final TasksBloc bloc;
  TasksProvider({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TasksBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TasksProvider)
            as TasksProvider)
        .bloc;
  }
}
