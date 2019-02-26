import 'package:taskshare/screens/task/tasks_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class InputTask extends StatelessWidget {
  const InputTask();

  static Widget withDependencies(BuildContext context) {
    return TasksBlocProvider.fromBlocContext(
      context: context,
      child: const InputTask(),
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.info('InputTaskPage build called');
    final bloc = TasksBlocProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Input New Task'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                ),
              ),
              onPressed: () {
                bloc.taskOperation.add(
                  TaskOperation(
                    task: Task(id: null, title: 'xxxx'),
                    type: TaskOperationType.add,
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: const [
            TextField(
              autofocus: true,
            )
          ],
        ));
  }
}
