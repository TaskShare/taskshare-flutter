import 'package:taskshare/bloc/tasks_provider.dart';
import 'package:taskshare/export/export_ui.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TasksProvider.of(context);
    return StreamBuilder(
      stream: bloc.tasks,
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        if (!snapshot.hasData) {
          return AppProgressIndicator();
        }
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final task = snapshot.data[index];
              return Dismissible(
                key: Key(task.id),
                onDismissed: (direction) {
                  bloc.delete(task);
                },
                background: Container(
                  color: Theme.of(context).errorColor,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(task.title),
                      leading: Checkbox(
                        onChanged: (value) {
                          task.done = value;
                          bloc.update(task);
                        },
                        value: task.done,
                      ),
                    ),
                    Divider(
                      height: 0.0,
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
