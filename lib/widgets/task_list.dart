import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_bloc_provider.dart';
import 'package:taskshare/widgets/task_list_tile.dart';
import 'package:taskshare/widgets/widgets.dart';

class TaskList extends StatefulWidget {
  TaskList();

  factory TaskList.forDesignTime() => TaskList();

  @override
  TaskListState createState() {
    return new TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  @override
  void initState() {
    super.initState();
    final bloc = TasksBlocProvider.of(context);
    bloc.taskOperations.listen((operation) {
      final task = operation.task;
      final type = operation.type;
      final l10n = L10N.of(context);
      String title;
      switch (type) {
        case TaskOperationType.checked:
          title = l10n.snackTaskDone(task.title);
          break;
        case TaskOperationType.deleted:
          title = l10n.snackTaskDeleted(task.title);
          break;
        case TaskOperationType.add:
        case TaskOperationType.updated:
          return;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            title,
          ),
          action: SnackBarAction(
            label: l10n.buttonUndo,
            onPressed: () {
              switch (type) {
                case TaskOperationType.checked:
                  task.doneTime = null;
                  bloc.taskOperation.add(TaskOperation(
                      task: task, type: TaskOperationType.updated));
                  break;
                case TaskOperationType.deleted:
                  bloc.taskOperation.add(
                      TaskOperation(task: task, type: TaskOperationType.add));
                  break;
                case TaskOperationType.add:
                case TaskOperationType.updated:
                  break;
              }
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = TasksBlocProvider.of(context);
    return StreamBuilder<List<Task>>(
      stream: bloc.tasks,
      initialData: bloc.tasks.value,
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
    );
  }
}
