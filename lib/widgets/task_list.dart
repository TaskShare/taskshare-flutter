import 'package:taskshare/bloc/task_event_bloc.dart';
import 'package:taskshare/bloc/task_event_bloc_provider.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_bloc_provider.dart';
import 'package:taskshare/widgets/task_list_tile.dart';
import 'package:taskshare/widgets/widgets.dart';

enum TaskCompletedKind { done, deleted }

class TaskList extends StatelessWidget {
  TaskList();

  factory TaskList.forDesignTime() => TaskList();

  @override
  Widget build(BuildContext context) {
    final bloc = TasksBlocProvider.of(context);

    return TaskEventBlocProvider(
      blocCreated: (eventBloc) {
        eventBloc.events.listen((event) => _handleTaskEvent(context, event));
      },
      child: StreamBuilder<List<Task>>(
        stream: bloc.tasks,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return AppProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final task = snapshot.data[index];
                return TaskListTile(
                  key: ValueKey(task.id),
                  task: task,
                );
              });
        },
      ),
    );
  }

  void _handleTaskEvent(
    BuildContext context,
    TaskEventContainer event,
  ) {
    final bloc = TasksBlocProvider.of(context);
    final task = event.task;
    switch (event.event) {
      case TaskEvent.checkChanged:
        _handleChecked(
          event.isChecked,
          context,
          task,
        );
        break;
      case TaskEvent.dismissed:
        bloc.taskDeletion.add(task);
        _showDonePrompt(
          context,
          event.task,
          TaskCompletedKind.deleted,
        );
        break;
    }
  }

  void _handleChecked(bool checked, BuildContext context, Task task) async {
    final bloc = TasksBlocProvider.of(context);
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

  void _showDonePrompt(
      BuildContext context, Task task, TaskCompletedKind kind) {
    final bloc = TasksBlocProvider.of(context);
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
