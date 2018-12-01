import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskshare/model/task.dart';

class TaskAdditionBloc implements Bloc {
  final _saveController = PublishSubject<String>();
  final _fullscreenController = PublishSubject<void>();
  final _addedController = PublishSubject<Task>();
  final _failedController = PublishSubject<Error>();

  TaskAdditionBloc() {
    _saveController.listen((title) {
      if (title == null || title.isEmpty) {
        _failedController.add(Error());
      } else {
        final task = Task(id: null, title: title);
        _addedController.add(task);
      }
    });
  }

  Stream<void> get fullscreenDemanded => _fullscreenController.stream;
  Sink<void> get demandFullscreen => _fullscreenController.sink;
  Stream<Task> get added => _addedController.stream;
  Stream<Error> get failed => _failedController.stream;
  Sink<String> get save => _saveController.sink;

  @override
  void dispose() {
    _fullscreenController.close();
    _saveController.close();
    _addedController.close();
    _failedController.close();
  }
}
