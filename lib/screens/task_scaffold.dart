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
    final defaultMediaQuery = MediaQuery.of(context);
    log.info('mediaQuery: $defaultMediaQuery');
    final bloc = TasksProvider.of(context);
    return Scaffold(
      bottomNavigationBar: BottomMenu(),
      appBar: _buildAppBar(),
      body: TaskList(),
      floatingActionButton: AddTaskButton(
        onPressed: () async {
          final value = await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                log.info('mediaQuery: $defaultMediaQuery');
                final viewInsets = MediaQuery.of(context).viewInsets;
                final bottomInset =
                    viewInsets.bottom - defaultMediaQuery.padding.bottom;
                log.info('bottomInset: $bottomInset');
                return AnimatedPadding(
                  padding: EdgeInsets.only(
                    top: viewInsets.top,
                    left: viewInsets.left,
                    right: viewInsets.right,
                    bottom: math.max(0.0, bottomInset),
                  ),
                  duration: Duration(milliseconds: 100),
                  curve: Curves.decelerate,
                  child: new MediaQuery.removeViewInsets(
                    removeLeft: true,
                    removeTop: true,
                    removeRight: true,
                    removeBottom: true,
                    context: context,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        elevation: 24.0,
                        type: MaterialType.card,
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
                      ),
                    ),
                  ),
                );
              });
          log.info(value);
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
