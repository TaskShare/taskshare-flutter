import 'package:flutter/material.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/screens/task_list.dart';
import 'package:taskshare/widgets/add_task_button.dart';
import 'package:taskshare/widgets/bottom_menu.dart';
import 'package:taskshare/widgets/menu_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AccountModel>(
        builder: (context, child, model) {
      return TasksProvider(
        groupName: model.user.uid,
        child: Scaffold(
          bottomNavigationBar: BottomMenu(),
          appBar: AppBar(
            title: Text('TaskShare'),
            actions: <Widget>[
              MenuButton()
            ],
          ),
          body: TaskList(),
          floatingActionButton: AddTaskButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
    });
  }
}


