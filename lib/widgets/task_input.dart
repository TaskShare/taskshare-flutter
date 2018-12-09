import 'package:flutter/material.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/l10n/l10n.dart';
import 'package:taskshare/util/app_logger.dart';

class TaskInput extends StatefulWidget {
  @override
  TaskInputState createState() {
    return new TaskInputState();
  }
}

class TaskInputState extends State<TaskInput> {
  // TODO: テキストを維持するために上に持っていく？
  TextEditingController _textController;
  final _focusNode = FocusNode();
  @override
  void initState() {
    log.info('TaskInputState initState');
    super.initState();
    _textController = TextEditingController();
    final bloc = TaskAdditionBlocProvider.of(context);
    bloc.added.listen((task) {
      _textController.clear();
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
          StreamBuilder<Error>(
            initialData: bloc.failed.value,
            stream: bloc.failed,
            builder: (context, snap) {
              return TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'New Task',
                  errorText: snap.data == null ? null : snap.data.toString(),
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
}
