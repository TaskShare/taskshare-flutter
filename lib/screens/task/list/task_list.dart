import 'package:taskshare/screens/task/list/task_animated_list.dart';
import 'package:taskshare/screens/task/list/task_list_tile.dart';
import 'package:taskshare/screens/task/tasks_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class TaskList extends StatefulWidget {
  const TaskList();

  factory TaskList.forDesignTime() => const TaskList();

  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  final _listKey = GlobalKey<AnimatedListState>();
  TaskAnimatedList _list;
  StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    final bloc = TasksBlocProvider.of(context);
    _list = TaskAnimatedList(
      listKey: _listKey,
      stream: bloc.tasks,
      removedItemBuilder: (task, context, animation) {
        return TaskListTile(
          key: ValueKey(task.id),
          task: task,
          animation: animation,
          onDismissed: null,
        );
      },
    );
    _subscription = bloc.taskOperations.listen((operation) {
      final l10n = L10N.of(context);
      final task = operation.task;
      final type = operation.type;
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
    return AnimatedList(
      key: _listKey,
      initialItemCount: _list.length,
      itemBuilder: (context, index, animation) {
        final task = _list[index];
        return TaskListTile(
          key: ValueKey(task.id),
          task: task,
          animation: animation,
          onDismissed: (_) {
            final bloc = TasksBlocProvider.of(context);
            _list.remove(task, skipAnimation: true);
            bloc.taskOperation.add(
              TaskOperation(
                task: task,
                type: TaskOperationType.deleted,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
