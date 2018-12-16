import 'package:logging/logging.dart';
import 'package:taskshare/app.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/service_provider.dart';
import 'package:taskshare/model/tasks_store.dart';
import 'package:taskshare/util/util.dart';
import 'package:taskshare/widgets/widgets.dart';

void main() {
  configureLogger(Level.FINEST);
  runApp(
    ServiceProvider(
      authenticator: GoogleAuthenticator(),
      tasksStore: TasksStoreFlutter(),
      logger: log,
      child: App(),
    ),
  );
}
