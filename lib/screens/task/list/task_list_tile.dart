import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskshare/model/task.dart';
import 'package:taskshare/screens/task/tasks_bloc_provider.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    @required Key key,
    @required this.task,
    @required this.animation,
    @required this.onDismissed,
  }) : super(key: key);
  final Task task;
  final Animation<double> animation;
  final DismissDirectionCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final bloc = TasksBlocProvider.of(context);
    return Dismissible(
      key: ValueKey(task.id),
      onDismissed: onDismissed,
      background: Container(
        color: Theme.of(context).errorColor,
      ),
      child: SizeTransition(
        sizeFactor: animation,
        child: Column(
          children: [
            ListTile(
              title: Text(task.title),
              leading: Checkbox(
                onChanged: (value) {
                  // server valueの方が良さそう
                  task.doneTime = value ? Timestamp.now() : null;
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
      ),
    );
  }
}
