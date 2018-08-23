import 'package:taskshare/app.dart';
import 'package:taskshare/bloc/BlocProvider.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/service_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

void main() {
  AppLogger.configure();
  final Authenticator authenticator = GoogleAuthenticator();
  final accountBloc = AccountBloc(authenticator: authenticator);
  final tasksBloc = TasksBloc(authenticator: authenticator);
  runApp(ServiceProvider(
    authenticator: authenticator,
    child: BlocProvider<AccountBloc>(
      bloc: accountBloc,
      child: BlocProvider<TasksBloc>(
        bloc: tasksBloc,
        child: App(),
      ),
    ),
  ));
}
