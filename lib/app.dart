import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/screens/home.dart';
import 'package:taskshare/screens/input_task.dart';
import 'package:taskshare/screens/setting.dart';
import 'package:taskshare/screens/task/tasks_bloc_provider.dart';
import 'package:taskshare/util/util.dart';
import 'package:taskshare/widgets/widgets.dart';

class App extends StatelessWidget {
  App();

  factory App.forDesignTime() => App();

  @override
  Widget build(BuildContext context) {
    logger.finest('App build called');
    return AccountBlocProvider(
      child: TasksBlocProvider(
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
      ),
    );
  }

  Map<String, WidgetBuilder> get _routes => {
        Home.routeName: (context) => Home(),
        Setting.routeName: (context) => Setting(),
      };

  Route _handleRoutes(RouteSettings settings) {
    switch (settings.name) {
      case InputTask.routeName:
        logger.warning('name: ${settings.name}');
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              logger.warning('InputTaskPage returned');
              return InputTask();
            });
    }
    return null;
  }
}
