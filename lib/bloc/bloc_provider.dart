import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BlocProvider({
    @required this.child,
    @required this.bloc,
    Key key,
  }) : super(key: key);

  static T of<T extends BlocBase>(BuildContext context) =>
      (context.ancestorWidgetOfExactType(_typeOf<BlocProvider<T>>())
              as BlocProvider<T>)
          .bloc;

  static Type _typeOf<T>() => T;

  @override
  State<StatefulWidget> createState() => _BlocProviderState();
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
