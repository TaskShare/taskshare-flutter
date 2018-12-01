import 'package:taskshare/bloc/task_addition_bloc.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/widgets/add_task_button.dart';
import 'package:taskshare/widgets/bottom_menu.dart';
import 'package:taskshare/widgets/menu_button.dart';
import 'package:taskshare/widgets/task_input.dart';
import 'package:taskshare/widgets/task_list.dart';
import 'package:taskshare/widgets/widgets.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() {
    return new TaskScreenState();
  }
}

class TaskScreenState extends State<TaskScreen> {
  TaskAdditionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TaskAdditionBlocProvider.of(context);
    _bloc.fullscreenDemanded.listen((x) => Navigator.of(context).pop());
    _bloc.added.listen((task) {
      _bloc.updateScreenMode.add(TaskScreenMode.list);
    });
    _bloc.failed.listen((error) {
      // TODO:
    });
  }

  @override
  Widget build(BuildContext context) {
    final main = Scaffold(
      bottomNavigationBar: BottomMenu(),
      appBar: _buildAppBar(),
      body: TaskList(),
      floatingActionButton: AddTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    return StreamBuilder<TaskScreenMode>(
      stream: _bloc.screenMode,
      initialData: _bloc.screenMode.value,
      builder: (context, snap) {
        switch (snap.data) {
          case TaskScreenMode.list:
            return main;
          case TaskScreenMode.input:
            // TODO: fade animation
            return Stack(
              children: [
                main,
                Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () =>
                          _bloc.updateScreenMode.add(TaskScreenMode.list),
                      child: Scaffold(
                        backgroundColor: Colors.black.withAlpha(100),
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: TaskInput(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
        }
      },
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text('TaskShare'),
        actions: [MenuButton()],
      );
}
