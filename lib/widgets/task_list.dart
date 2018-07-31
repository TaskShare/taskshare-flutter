import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';

enum TaskCompletedKind {
  done,
  deleted
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return StreamBuilder<List<Task>>(
      stream: bloc.tasks,
      builder: (context, snapshot) {
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
                  bloc.taskDeletion.add(task);
                  _showDonePrompt(context, task, TaskCompletedKind.deleted);
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
    bloc.taskUpdate.add(task);
    if (!checked) {
      return;
    }
    await Future<void>.delayed(Duration(milliseconds: 500));
    task.updateTime = DateTime.now();
    bloc.taskUpdate.add(task);
    _showDonePrompt(context, task, TaskCompletedKind.done);
  }

  _showDonePrompt(BuildContext context, Task task, TaskCompletedKind kind) {
    final bloc = TasksProvider.of(context);
    final l10n = L10N.of(context);
    String title;
    switch (kind) {
      case TaskCompletedKind.done:
        title = l10n.snackTaskDone(task.title);
        break;
      case TaskCompletedKind.deleted:
        title = l10n.snackTaskDeleted(task.title);
        break;
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
        ),
        action: SnackBarAction(
          label: l10n.buttonUndo,
          onPressed: () {
            switch (kind) {
              case TaskCompletedKind.done:
                task.doneTime = null;
                bloc.taskUpdate.add(task);
                break;
              case TaskCompletedKind.deleted:
                bloc.taskUpdate.add(task);
                break;
            }
          },
        ),
      ),
    );
  }
}
