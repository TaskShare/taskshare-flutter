import 'package:flutter/material.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/pages/home_page.dart';
import 'package:taskshare/pages/welcome_page.dart';
import 'package:taskshare/widgets/app_progress_indicator.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AccountModel>(
      builder: (context, child, model) {
        switch (model.state) {
          case AccountState.none:
            return AppProgressIndicator();
          case AccountState.signedOut:
            return WelcomePage();
          case AccountState.signedIn:
            return HomePage();
        }
        assert(false);
        return Container();
      },
    );
  }
}