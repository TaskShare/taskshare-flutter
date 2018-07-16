import 'package:flutter/material.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/pages/input_task_page.dart';
import 'package:taskshare/util/app_logger.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddTaskButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: onPressed,
    );
  }
}
