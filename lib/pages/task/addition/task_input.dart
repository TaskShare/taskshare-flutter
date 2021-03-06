import 'package:flutter/material.dart';
import 'package:taskshare/l10n/l10n.dart';

import '../../input_task.dart';
import 'task_addition_bloc_provider.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({
    Key key,
    @required this.textController,
  }) : super(key: key);
  final TextEditingController textController;

  @override
  TaskInputState createState() => TaskInputState();
}

class TaskInputState extends State<TaskInput> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = TaskAdditionBlocProvider.of(context);
    final l10n = L10N.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 8,
      ),
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
            initialData: bloc.failed.value,
            stream: bloc.failed,
            builder: (context, snap) {
              return TextField(
                controller: widget.textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'New Task',
                  errorText: snap.data,
                ),
                onSubmitted: (text) {
                  bloc.save.add(text);
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.open_in_new,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    InputTask.routeName,
                    arguments: context,
                  );
                },
                color: Theme.of(context).accentColor,
              ),
              FlatButton(
                onPressed: () async {
                  bloc.save.add(bloc.text.value);
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

  void focus() {
    FocusScope.of(context).requestFocus(_focusNode);
  }
}
