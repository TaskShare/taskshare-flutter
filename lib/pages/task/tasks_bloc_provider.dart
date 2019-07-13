import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taskshare/model/service_provider.dart';

import 'tasks_bloc.dart';

class TasksBlocProvider extends BlocProvider<TasksBloc> {
  TasksBlocProvider({@required Widget child})
      : super(
          child: child,
          creator: (context, _bag) {
            final provider = ServiceProvider.of(context);
            return TasksBloc(
              authenticator: provider.authenticator,
              store: provider.tasksStore,
            );
          },
        );

  TasksBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
          context: context,
          child: child,
        );

  static TasksBloc of(BuildContext context) => BlocProvider.of(context);
}
