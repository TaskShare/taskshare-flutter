import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/util/util.dart';
import 'package:taskshare/widgets/widgets.dart';

import 'pages/home.dart';
import 'pages/input_task.dart';
import 'pages/setting.dart';

class App extends StatelessWidget {
  const App();

  factory App.forDesignTime() => const App();

  @override
  Widget build(BuildContext context) {
    logger.finest('App build called');
    return AccountBlocProvider(
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
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

  Map<String, WidgetBuilder> get _routes => {
        Home.routeName: (context) => const Home(),
        Setting.routeName: (context) => const Setting(),
      };

  Route _handleRoutes(RouteSettings settings) {
    switch (settings.name) {
      case InputTask.routeName:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          fullscreenDialog: true,
          builder: (_context) =>
              InputTask.withDependencies(settings.arguments as BuildContext),
        );
        break;
    }
    assert(false);
    return null;
  }
}
