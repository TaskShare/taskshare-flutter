import 'package:taskshare/app.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/service_provider.dart';
import 'package:taskshare/model/tasks_store.dart';
import 'package:taskshare/widgets/widgets.dart';

void main() {
  runApp(
    ServiceProvider(
      authenticator: GoogleAuthenticator(),
      tasksStore: TasksStoreFlutter(),
      child: const App(),
    ),
  );
}
