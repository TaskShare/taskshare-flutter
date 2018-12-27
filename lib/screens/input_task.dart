import 'package:taskshare/screens/task/tasks_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class InputTask extends StatelessWidget {
  static const routeName = '/input_task';

  const InputTask();

  factory InputTask.forDesignTime() => const InputTask();

  @override
  Widget build(BuildContext context) {
    logger.warning('InputTaskPage build called');
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
