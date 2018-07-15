import 'package:flutter/material.dart';
import 'package:taskshare/bloc/tasks_bloc.dart';
import 'package:taskshare/bloc/tasks_provider.dart';

class InputTaskPage extends StatelessWidget {
  static const routeName = "/input_task";
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Input New Task'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                ),
              ),
              onPressed: () async {
                await bloc.add(new Task(id: null, title: 'xxxx'));
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            TextField(
              autofocus: true,
            )
          ],
        ));
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
