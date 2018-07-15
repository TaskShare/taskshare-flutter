import 'package:flutter/material.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/pages/input_task_page.dart';

class AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
//        Navigator.of(context).push(
//          MaterialPageRoute(
//            fullscreenDialog: true,
//            builder: (context) {
//              return InputTaskPage();
//            },
//          ),
//        );
        // TODO:
        bloc.add(new Task(id: null, title: "hello"));
      },
    );
  }
}
