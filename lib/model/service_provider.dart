import 'package:flutter/material.dart';
import 'package:taskshare/model/authenticator.dart';

import 'model.dart';

class ServiceProvider extends InheritedWidget {
  final Authenticator authenticator;

  ServiceProvider({
    @required this.authenticator,
    @required Widget child,
    Key key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ServiceProvider oldWidget) =>
      oldWidget.authenticator != authenticator;

  static ServiceProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(ServiceProvider) as ServiceProvider;
}
