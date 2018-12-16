import 'package:flutter/material.dart';
import 'package:taskshare/l10n/l10n.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc_provider.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton();

  factory AddTaskButton.forDesignTime() => AddTaskButton();

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.of(context);
    final bloc = TaskAdditionBlocProvider.of(context);
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(l10n.addTask),
      onPressed: () async {
        bloc.updateScreenMode.add(TaskScreenMode.input);
      },
    );
  }
}
