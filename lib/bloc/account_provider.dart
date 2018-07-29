import 'package:flutter/material.dart';
import 'package:taskshare/export/export_model.dart';
import 'account_bloc.dart';
export 'account_bloc.dart';
export 'package:firebase_auth/firebase_auth.dart';

class AccountProvider extends InheritedWidget {
  final AccountBloc bloc;
  AccountProvider({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AccountBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AccountProvider)
            as AccountProvider)
        .bloc;
  }
}