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
      (context.inheritFromWidgetOfExactType(_typeOf<_Inherited<T>>())
              as _Inherited<T>)
          .bloc;

  static Type _typeOf<T>() => T;

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) => _Inherited<T>(
        bloc: widget.bloc,
        child: widget.child,
      );

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _Inherited<T extends BlocBase> extends InheritedWidget {
  final T bloc;

  _Inherited({
    Key key,
    this.bloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_Inherited old) => old.bloc != bloc;
}
