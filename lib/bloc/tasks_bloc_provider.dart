import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/model/service_provider.dart';

class TasksBlocProvider extends BlocProvider<TasksBloc> {
  TasksBlocProvider({
    @required Widget child,
  }) : super(
          child: child,
          creator: (context) {
            final container = ServiceProvider.of(context);
            return TasksBloc(authenticator: container.authenticator);
          },
        );

  static TasksBloc of(BuildContext context) => BlocProvider.of(context);
}
