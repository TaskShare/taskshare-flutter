import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:taskshare/bloc/task_event_bloc.dart';

class TaskEventBlocProvider extends BlocProvider<TaskEventBloc> {
  TaskEventBlocProvider({
    @required BlocCreated<TaskEventBloc> blocCreated,
    @required Widget child,
  }) : super(
          child: child,
          blocCreated: blocCreated,
          creator: (context) {
            return TaskEventBloc();
          },
        );

  static TaskEventBloc of(BuildContext context) => BlocProvider.of(context);
}
