import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';

class InputTask extends StatelessWidget {
  static const routeName = "/input_task";
  @override
  Widget build(BuildContext context) {
    log.warning('InputTaskPage build called');
    final bloc = TasksProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Input New Task'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                ),
              ),
              onPressed: () {
                bloc.taskUpdate.add(new Task(id: null, title: 'xxxx'));
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            TextField(
              autofocus: true,
            )
          ],
        ));
  }
}
