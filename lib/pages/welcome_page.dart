import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/util/app_logger.dart';
import 'package:taskshare/widgets/app_progress_indicator.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  bool _isLogginedIn = false;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AccountModel>(
        builder: (context, child, model) {
      return Scaffold(
        body: _buildBody(model),
      );
    });
  }

  Widget _buildBody(AccountModel model) {
    final List<Widget> children = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('グループ共有に特化したタスク管理アプリです(　´･‿･｀)'),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text('Googleログイン'),
              onPressed: () async {
                setState(() {
                  _isLogginedIn = true;
                });
                setState(() {
                  _isLogginedIn;
                });
                FirebaseUser user;
                try {
                  user = await model.signIn();
                } catch (error) {
                  log.warning(error);
                }
                log.info('user: $user');
                setState(() {
                  _isLogginedIn = false;
                });
              },
            )
          ],
        ),
      )
    ];
    if (_isLogginedIn) {
      children.add(AppProgressIndicator(
        color: Colors.black.withAlpha(50),
      ));
    }
    return Stack(
      children: children,
    );
  }
}
