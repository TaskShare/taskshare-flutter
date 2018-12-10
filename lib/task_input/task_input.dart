import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskshare/l10n/l10n.dart';
import 'package:taskshare/task_input/task_addtion_bloc_provider.dart';

class TaskInput extends StatefulWidget {
  @override
  TaskInputState createState() => TaskInputState();
}

class TaskInputState extends State<TaskInput> {
  // TODO: テキストを維持するために上に持っていく？
  TextEditingController _textController;
  final _focusNode = FocusNode();
  StreamSubscription _blocSubscription;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    final bloc = TaskAdditionBlocProvider.of(context);
    _blocSubscription = bloc.added.listen((task) {
      _textController.clear();
    });
    _textController.addListener(() {
      bloc.updateText.add(_textController.text);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = TaskAdditionBlocProvider.of(context);
    final l10n = L10N.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 8.0,
      ),
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
            initialData: bloc.failed.value,
            stream: bloc.failed,
            builder: (context, snap) {
              // TODO: expand touch area
              return TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'New Task',
                  errorText: snap.data,
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.open_in_new,
                ),
                onPressed: () {
                  bloc.demandFullscreen.add(null);
                },
                color: Theme.of(context).accentColor,
              ),
              FlatButton(
                onPressed: () async {
                  bloc.save.add(_textController.text);
                },
                child: Text(
                  l10n.buttonSave,
                ),
                textTheme: ButtonTextTheme.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _blocSubscription.cancel();
    super.dispose();
  }
}
