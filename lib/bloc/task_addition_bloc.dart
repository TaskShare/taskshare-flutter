import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskshare/model/task.dart';

enum TaskScreenMode { list, input }

class TaskAdditionBloc implements Bloc {
  final _saveController = PublishSubject<String>();
  final _fullscreenController = PublishSubject<void>();
  final _addedController = PublishSubject<Task>();
  final _failedController = PublishSubject<Error>();
  final _screenStateController =
      BehaviorSubject<TaskScreenMode>(seedValue: TaskScreenMode.list);

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
  ValueObservable<TaskScreenMode> get screenMode =>
      _screenStateController.stream;
  Sink<TaskScreenMode> get updateScreenMode => _screenStateController.sink;

  @override
  void dispose() {
    _screenStateController.close();
    _fullscreenController.close();
    _saveController.close();
    _addedController.close();
    _failedController.close();
  }
}
