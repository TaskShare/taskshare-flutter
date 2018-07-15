import 'package:flutter/material.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/widgets/app_progress_indicator.dart';

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
              return ListTile(
                title: Text(task.title),
              );
            });
      },
    );
  }
}
