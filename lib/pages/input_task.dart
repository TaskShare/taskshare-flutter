import 'package:taskshare/widgets/widgets.dart';

import 'task/tasks_bloc_provider.dart';

// TOOD: 途中
class InputTask extends StatelessWidget {
  const InputTask();

  static const routeName = '/input_task';

  static Widget withDependencies(BuildContext context) {
    return TasksBlocProvider.fromBlocContext(
      context: context,
      child: const InputTask(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Input New Task'),
          actions: <Widget>[
            Builder(
              builder: (context) => FlatButton(
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text('Not implemented'),
                  ));
                },
              ),
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
