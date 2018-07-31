import 'package:taskshare/bloc/account_provider.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/widgets/menu_button.dart';
import 'package:taskshare/widgets/task_list.dart';
import 'package:taskshare/widgets/add_task_button.dart';

import 'package:taskshare/widgets/bottom_menu.dart';

class TaskScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountProvider.of(context);
    return StreamBuilder<FirebaseUser>(
      initialData: accountBloc.lastUser,
      stream: accountBloc.user,
      builder: (context, snap) {
        // TODO: ここで毎回インスタンス生成して良い？
        final tasksBloc = TasksBloc(groupName: snap.data.uid);
        return TasksProvider(
          bloc: tasksBloc,
          child: Scaffold(
            bottomNavigationBar: BottomMenu(),
            appBar: _buildAppBar(),
            body: TaskList(),
            floatingActionButton: AddTaskButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() => AppBar(
      title: Text('TaskShare'),
      actions: [MenuButton()],
    );
}
