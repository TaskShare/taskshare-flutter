import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:taskshare/pages/root_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: AccountModel(),
      child: MaterialApp(
        title: 'TaskShare',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.purpleAccent,
          errorColor: Colors.red
        ),
//        home: RootPage(),
        onGenerateRoute: routes,
      ),
    );
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == '/') {
    return MaterialPageRoute(
      builder: (context) {
        return RootPage();
      }
    );
  }
  // TODO:
  return MaterialPageRoute(
      builder: (context) {
        return Text('(　´･‿･｀)');
      }
  );
}