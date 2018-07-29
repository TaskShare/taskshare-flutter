import 'package:taskshare/app.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'export/export_ui.dart';

void main() {
  AppLogger.configure();
  final accountBloc = AccountBloc();
  runApp(new App(
    accountBloc: accountBloc,
  ));
}
