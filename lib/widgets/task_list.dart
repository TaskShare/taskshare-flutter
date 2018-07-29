import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return StreamBuilder(
      stream: bloc.tasks,
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        if (!snapshot.hasData) {
          return AppProgressIndicator();
        }
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final task = snapshot.data[index];
              return Dismissible(
                key: Key(task.id),
                onDismissed: (direction) {
                  bloc.delete(task);
                  _showDeletedPrompt(context, task);
                },
                background: Container(
                  color: Theme.of(context).errorColor,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(task.title),
                      leading: Checkbox(
                        onChanged: (value) {
                          _handleChecked(value, context, task);
                        },
                        value: task.doneTime != null,
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  _handleChecked(bool checked, BuildContext context, Task task) async {
    final bloc = TasksProvider.of(context);
    if (checked) {
      task.doneTime = DateTime.now();
    } else {
      task.doneTime = null;
    }
    bloc.update(task);
    if (!checked) {
      return;
    }
    await Future<void>.delayed(Duration(milliseconds: 500));
    task.updateTime = DateTime.now();
    await bloc.update(task);
    _showDonePrompt(context, task);
  }

  _showDonePrompt(BuildContext context, Task task) {
    final bloc = TasksProvider.of(context);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task "${task.title}" done',
        ), // TODO
        action: SnackBarAction(
          label: 'UNDO', // TODO
          onPressed: () {
            task.doneTime = null;
            bloc.update(task);
          },
        ),
      ),
    );
  }

  // TODO: 上のメソッドと合体？
  _showDeletedPrompt(BuildContext context, Task task) {
    final bloc = TasksProvider.of(context);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task "${task.title}" deleted',
        ), // TODO
        action: SnackBarAction(
          label: 'UNDO', // TODO
          onPressed: () {
            bloc.update(task);
          },
        ),
      ),
    );
  }
}
