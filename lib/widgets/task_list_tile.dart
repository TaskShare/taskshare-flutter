import 'package:flutter/material.dart';
import 'package:taskshare/bloc/task_event_bloc.dart';
import 'package:taskshare/bloc/task_event_bloc_provider.dart';
import 'package:taskshare/model/task.dart';

class TaskListTile extends StatelessWidget {
  final Task task;

  const TaskListTile({
    @required Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = TaskEventBlocProvider.of(context);
    return Dismissible(
      key: ValueKey(task.id),
      onDismissed: (direction) {
        bloc.eventOccurred.add(
          TaskEventContainer(
            task: task,
            event: TaskEvent.dismissed,
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
                bloc.eventOccurred.add(
                  TaskEventContainer(
                    task: task,
                    event: TaskEvent.checkChanged,
                    isChecked: value,
                  ),
                );
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
  }
}
