import 'package:flutter/material.dart';
import 'package:taskshare/model/task.dart';
import 'package:taskshare/screens/task/tasks_bloc_provider.dart';

class TaskListTile extends StatelessWidget {
  final Task task;

  const TaskListTile({
    @required Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = TasksBlocProvider.of(context);
    return Dismissible(
      key: ValueKey(task.id),
      onDismissed: (direction) {
        bloc.taskOperation.add(
          TaskOperation(
            task: task,
            type: TaskOperationType.deleted,
          ),
        );
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
                task.doneTime = value ? DateTime.now() : null;
                bloc.taskOperation.add(
                  TaskOperation(
                    task: task,
                    type: value
                        ? TaskOperationType.checked
                        : TaskOperationType.updated,
                  ),
                );
              },
              value: task.doneTime != null,
            ),
          ),
          const Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
