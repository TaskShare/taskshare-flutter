import 'package:taskshare/bloc/account_provider.dart';
import 'package:taskshare/screens/home.dart';
import 'package:taskshare/screens/input_task.dart';
import 'package:taskshare/screens/setting.dart';
import 'export/export_ui.dart';

class App extends StatelessWidget {
  final AccountBloc accountBloc;

  App({@required this.accountBloc});
  @override
  Widget build(BuildContext context) {
    log.warning('App build called');
    return AccountProvider(
      bloc: accountBloc,
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ja', 'JP'),
        ],
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
