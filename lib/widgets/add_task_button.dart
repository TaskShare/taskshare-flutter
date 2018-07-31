import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';

class AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors
            .transparent, // showModalBottomSheetの背景色をここだけ変えるためのWork Around
      ),
      child: _AddTaskButton(),
    );
  }
}

class _AddTaskButton extends StatefulWidget {
  @override
  _AddTaskButtonState createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<_AddTaskButton> {
  var _isInputting = false;
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (_isInputting) {
      return Container();
    }
    final l10n = L10N.of(context);
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(l10n.addTask),
      onPressed: () async {
        setState(() {
          _isInputting = true;
        });
        await _showModalBottomSheet(context);
        await Future.delayed(Duration(milliseconds: 400));
        setState(() {
          _isInputting = false;
        });
      },
    );
  }

  Future _showModalBottomSheet(BuildContext context) {
    final bloc = TasksProvider.of(context);
    final l10n = L10N.of(context);
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: 'New Task',
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.open_in_new,
                      ),
                      onPressed: () {
                        _pop(context);
                      },
                      color: Theme.of(context).accentColor,
                    ),
                    FlatButton(
                      onPressed: () async {
                        _saveTask(bloc, context);
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
          ),
        );
      },
    );
  }

  void _saveTask(TasksBloc bloc, BuildContext context) {
    final title = textController.text;
    final task = new Task(id: null, title: title);
    log.info('wiil create task: $task');
    bloc.taskUpdate.add(task);
    _pop(context);
  }

  void _pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
