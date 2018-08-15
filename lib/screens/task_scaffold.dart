import 'package:taskshare/widgets/add_task_button.dart';
import 'package:taskshare/widgets/bottom_menu.dart';
import 'package:taskshare/widgets/menu_button.dart';
import 'package:taskshare/widgets/task_list.dart';
import 'package:taskshare/widgets/widgets.dart';

class TaskScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomMenu(),
        appBar: _buildAppBar(),
        body: TaskList(),
        floatingActionButton: AddTaskButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  AppBar _buildAppBar() => AppBar(
        title: Text('TaskShare'),
        actions: [MenuButton()],
      );
}
