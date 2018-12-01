import 'package:flutter/material.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/l10n/l10n.dart';

class TaskInput extends StatefulWidget {
  @override
  TaskInputState createState() {
    return new TaskInputState();
  }
}

class TaskInputState extends State<TaskInput> {
  TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    final bloc = TaskAdditionBlocProvider.of(context);
    bloc.added.listen((task) {
      _textController.clear();
    });
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
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'New Task',
//              errorText: 'hoge',
            ),
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
}
