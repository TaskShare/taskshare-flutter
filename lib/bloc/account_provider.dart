import 'package:flutter/material.dart';
import 'package:taskshare/export/export_model.dart';
import 'account_bloc.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'account_bloc.dart';

class AccountProvider extends InheritedWidget {
  final AccountBloc bloc;
  AccountProvider({
    @required Widget child,
    @required this.bloc,
    Key key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AccountProvider oldWidget) => oldWidget.bloc != bloc;

  static AccountBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(AccountProvider) as AccountProvider)
          .bloc;
}
