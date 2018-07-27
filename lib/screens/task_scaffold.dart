import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/widgets/menu_button.dart';
import 'package:taskshare/widgets/task_list.dart';
import 'package:taskshare/widgets/add_task_button.dart';

import 'package:taskshare/widgets/bottom_menu.dart';

class TaskScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(),
      appBar: _buildAppBar(),
      body: TaskList(),
      floatingActionButton: AddTaskButton(),
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
