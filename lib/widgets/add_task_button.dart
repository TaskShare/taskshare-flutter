import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';

class AddTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return FloatingActionButton.extended(
//        elevation: 4.0,
      icon: const Icon(Icons.add),
      label: const Text('Add a new task'),
      onPressed: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.black54,
              child: Container(
                padding: MediaQuery.of(context).viewInsets,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 20.0,
                    bottom: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: 'New Task',
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: new Icon(
                              Icons.open_in_new,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Theme.of(context).accentColor,
                          ),
                          FlatButton(
                            onPressed: () async {
                              bloc.add(new Task(id: null, title: 'aaa'));
                              Navigator.of(context).pop('hoge');
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            color: Colors.white,
                            splashColor: Colors.blue,
                            textColor: Theme.of(context).accentColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
