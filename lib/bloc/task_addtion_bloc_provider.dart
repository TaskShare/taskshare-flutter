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
          creator: (context, bag) {
            final bloc = TaskAdditionBloc();
            final tasksBloc = TasksBlocProvider.of(context);
            final subscription = bloc.added.listen((task) {
              tasksBloc.taskOperation.add(
                TaskOperation(
                  task: task,
                  type: TaskOperationType.add,
                ),
              );
            });
            bag.onDisposed = subscription.cancel;
            return bloc;
          },
        );

  static TaskAdditionBloc of(BuildContext context) => BlocProvider.of(context);
}
