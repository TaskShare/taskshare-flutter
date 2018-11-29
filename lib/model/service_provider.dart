import 'package:flutter/widgets.dart';
import 'package:taskshare/model/authenticator.dart';

class ServiceProvider extends InheritedWidget {
  final Authenticator authenticator;

  ServiceProvider({
    @required this.authenticator,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static ServiceProvider of(BuildContext context) => context
      .ancestorInheritedElementForWidgetOfExactType(ServiceProvider)
      .widget as ServiceProvider;
}
