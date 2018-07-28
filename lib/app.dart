import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/model/account.dart';
import 'package:taskshare/screens/home.dart';
import 'package:taskshare/screens/input_task.dart';
import 'package:taskshare/screens/setting.dart';

import 'export/export_ui.dart';

class App extends StatelessWidget {
  final Account account;

  App({@required this.account});
  @override
  Widget build(BuildContext context) {
    log.warning('App build called');
    return ScopedModel(
      model: account,
      child: ScopedModelDescendant<Account>(
        builder: (context, child, model) {
          // TODO: もっと上へ
          final taskBloc = TasksBloc(groupName: account.user?.uid);
          return TasksProvider(
            bloc: taskBloc,
            child: MaterialApp(
              title: 'TaskShare',
              theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  accentColor: Colors.deepPurpleAccent,
                  errorColor: Colors.red),
              initialRoute: Home.routeName,
              routes: _routes,
              onGenerateRoute: _handleRoutes,
            ),
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> get _routes {
    return {
      Home.routeName: (context) => Home(),
      Setting.routeName: (context) => Setting(),
    };
  }

  Route _handleRoutes(RouteSettings settings) {
    switch (settings.name) {
      case InputTask.routeName:
        log.warning('name: ${settings.name}');
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
//          log.warning('bloc: ${TasksProvider.of(context)}');

              log.warning('InputTaskPage returned');
              return InputTask();
            });
    }
    return null;
  }
}
