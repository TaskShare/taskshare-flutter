import 'package:taskshare/app.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'export/export_ui.dart';

void main() {
  AppLogger.configure();
  final accountBloc = AccountBloc();
  final tasksBloc = TasksBloc();
  accountBloc.user.map((user) => user?.uid).listen(tasksBloc.groupChanger.add);
  runApp(App(
    accountBloc: accountBloc,
    tasksBloc: tasksBloc,
  ));
}
