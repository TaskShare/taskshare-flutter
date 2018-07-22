import 'package:taskshare/export/export_ui.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddTaskButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: onPressed,
    );
  }
}
