import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/model/account_model.dart';

class SettingPage extends StatelessWidget {
  static const routeName = "/settings";
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AccountModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(model.user.toString()),
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  title: Text(
                    'Sign out',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                  onTap: () async {
                    await model.signOut();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
      },
    );
  }
}
