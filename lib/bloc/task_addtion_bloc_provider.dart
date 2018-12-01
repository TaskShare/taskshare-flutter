import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taskshare/bloc/task_addition_bloc.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_bloc_provider.dart';

class TaskAdditionBlocProvider extends BlocProvider<TaskAdditionBloc> {
  TaskAdditionBlocProvider({
    @required Widget child,
  }) : super(
          child: child,
          creator: (context) {
            final bloc = TaskAdditionBloc();
            final tasksBloc = TasksBlocProvider.of(context);
            bloc.added.listen((task) {
              tasksBloc.taskOperation.add(
                TaskOperation(
                  task: task,
                  type: TaskOperationType.add,
                ),
              );
            });
            return bloc;
          },
        );

  static TaskAdditionBloc of(BuildContext context) => BlocProvider.of(context);
}
