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
  @override
  Widget build(BuildContext context) {
    final accountModel = AccountModel();
    return ScopedModel(
      model: accountModel,
      child: ScopedModelDescendant<AccountModel>(
        builder: (context, child, model) {
          final bloc = TasksBloc(groupName: accountModel.user?.uid);
          return TasksProvider(
            bloc: bloc,
            child: MaterialApp(
              title: 'TaskShare',
              theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  accentColor: Colors.purpleAccent,
                  errorColor: Colors.red),
//        home: RootPage(),
              onGenerateRoute: routes,
            ),
          );
        },
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == '/') {
    return MaterialPageRoute(builder: (context) {
      return RootPage();
    });
  } else if (settings.name == InputTaskPage.routeName) {
    return MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
//          log.warning('bloc: ${TasksProvider.of(context)}');
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
