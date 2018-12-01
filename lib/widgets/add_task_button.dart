import 'package:taskshare/bloc/task_addition_bloc.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class AddTaskButton extends StatelessWidget {
  AddTaskButton();

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
