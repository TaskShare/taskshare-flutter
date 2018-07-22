import 'package:taskshare/app.dart';
import 'package:taskshare/model/account.dart';
import 'export/export_ui.dart';

void main() {
  AppLogger.configure();
  final account = Account();
  runApp(new App(
    account: account,
  ));
}
