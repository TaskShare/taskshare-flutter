import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taskshare/model/service_provider.dart';
import 'package:taskshare/screens/task/tasks_bloc.dart';

export 'package:taskshare/screens/task/tasks_bloc.dart';

class TasksBlocProvider extends BlocProvider<TasksBloc> {
  TasksBlocProvider({
    @required Widget child,
  }) : super(
          child: child,
          creator: (context, _bag) {
            final provider = ServiceProvider.of(context);
            return TasksBloc(
              authenticator: provider.authenticator,
              store: provider.tasksStore,
              logger: provider.logger,
            );
          },
        );

  static TasksBloc of(BuildContext context) => BlocProvider.of(context);
}
