import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/widgets/menu_button.dart';
import 'package:taskshare/widgets/task_list.dart';
import 'package:taskshare/widgets/add_task_button.dart';
import 'dart:math' as math;

import 'package:taskshare/widgets/bottom_menu.dart';

class TaskScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return Scaffold(
      bottomNavigationBar: BottomMenu(),
      appBar: _buildAppBar(),
      body: TaskList(),
      floatingActionButton: AddTaskButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        autofocus: true,
                      ),
                      RaisedButton(
                        child: Text('ADD'),
                        onPressed: () async {
                          bloc.add(new Task(id: null, title: 'aaa'));
                          Navigator.of(context).pop('hoge');
                        },
                      ),
                    ],
                  ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('TaskShare'),
      actions: <Widget>[MenuButton()],
    );
  }
}
