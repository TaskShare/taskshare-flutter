import 'package:flutter/widgets.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/tasks_store.dart';
import 'package:taskshare/util/logger.dart';

class ServiceProvider extends InheritedWidget {
  final Authenticator authenticator;
  final TasksStore tasksStore;
  final Logger logger;

  ServiceProvider({
    @required this.authenticator,
    @required this.tasksStore,
    @required this.logger,
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static ServiceProvider of(BuildContext context) => context
      .ancestorInheritedElementForWidgetOfExactType(ServiceProvider)
      .widget as ServiceProvider;
}
