import 'package:flutter/material.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/pages/input_task_page.dart';
import 'package:taskshare/util/app_logger.dart';

class AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {

        log.warning('onPressed');
        Navigator.of(context).pushNamed(InputTaskPage.routeName);
//        Navigator.of(context).push(
//          MaterialPageRoute(
////            fullscreenDialog: true,
//            builder: (context) {
//              log.warning('context: $context');
//              return InputTaskPage();
//            },
//          ),
//        );
        // TODO:
//        bloc.add(new Task(id: null, title: "hello"));
      },
    );
  }
}
