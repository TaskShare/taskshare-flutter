import 'package:flutter/material.dart';

class InputTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(24),
      body: Text('hoge'),
    );
  }
}

//class MyTransition extends MaterialPageRoute {
//
//  MyTransition({
//    @required WidgetBuilder builder,
//    RouteSettings settings,
//    this.maintainState = true,
//    bool fullscreenDialog = false,
//  }) : assert(builder != null),
//        super(settings: settings, fullscreenDialog: fullscreenDialog) {
//    // ignore: prefer_asserts_in_initializer_lists , https://github.com/dart-lang/sdk/issues/31223
//    assert(opaque);
//  }
//  @override
//  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//
//    return super.buildTransitions(context, animation, secondaryAnimation, child);
//  }
//}