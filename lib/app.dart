import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:taskshare/pages/input_task_page.dart';
import 'package:taskshare/pages/root_page.dart';
import 'package:taskshare/pages/setting_page.dart';
import 'package:taskshare/util/app_logger.dart';

class App extends StatelessWidget {
  final AccountModel account;

  App({@required this.account});
  @override
  Widget build(BuildContext context) {
    log.warning('App build called');
    return ScopedModel(
      model: account,
      child: ScopedModelDescendant<AccountModel>(
        builder: (context, child, model) {
          // TODO: もっと上へ
          final taskBloc = TasksBloc(groupName: account.user?.uid);
          return TasksProvider(
            bloc: taskBloc,
            child: MaterialApp(
              title: 'TaskShare',
              theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  accentColor: Colors.purpleAccent,
                  errorColor: Colors.red),
              home: RootPage(),
//              routes: { SettingPage.routeName: (context) => SettingPage() },
              onGenerateRoute: routes,
            ),
          );
        },
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == InputTaskPage.routeName) {
    log.warning('name: ${settings.name}');
    return MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
//          log.warning('bloc: ${TasksProvider.of(context)}');

          log.warning('InputTaskPage returned');
          return InputTaskPage();
        });
  } else if (settings.name == SettingPage.routeName) {
    return MaterialPageRoute(builder: (context) {
      return SettingPage();
    });
  }
  // TODO:
  return MaterialPageRoute(builder: (context) {
    return Text('(　´･‿･｀)');
  });
}
