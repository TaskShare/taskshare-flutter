import 'package:flutter/material.dart';
import 'package:taskshare/l10n/l10n.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc_provider.dart';
import 'package:taskshare/screens/task/task_page_state.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton();

  factory AddTaskButton.forDesignTime() => const AddTaskButton();

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.of(context);
    final bloc = TaskAdditionBlocProvider.of(context);
    return FloatingActionButton.extended(
      icon: const Icon(Icons.add),
      label: Text(l10n.addTask),
      onPressed: () async {
        TaskPageModel.of(context).update(mode: TaskScreenMode.input);
      },
    );
  }
}
