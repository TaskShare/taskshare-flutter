import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/model/account_model.dart';
import 'package:taskshare/pages/setting_page.dart';

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AccountModel>(
        builder: (context, child, model) {
      return IconButton(
        icon: ClipOval(
          child: Image.network(
            model.user.photoUrl,
            fit: BoxFit.cover,
          ),
        ),
        onPressed: () {
//          Navigator.of(context, rootNavigator: true).push(
//            CupertinoPageRoute<void>(
//              fullscreenDialog: true,
//              builder: (context) {
//                return SettingPage();
//              },
//            ),
//          );
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) {
//                return SettingPage();
//              },
//            ),
//          );

          Navigator.of(context).pushNamed(SettingPage.routeName);
        },
      );
    });
  }
}
