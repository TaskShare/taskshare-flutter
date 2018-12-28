import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taskshare/model/task.dart';

class TaskAdditionBloc implements Bloc {
  final _saveController = PublishSubject<String>();
  final _addedController = PublishSubject<Task>();
  final _failedController = BehaviorSubject<String>(seedValue: null);
  final _textController = BehaviorSubject<String>();

  TaskAdditionBloc() {
    _saveController.listen((title) {
      if (title == null || title.isEmpty) {
        _failedController.add('Input task title.');
      } else {
        final task = Task(id: null, title: title);
        _addedController.add(task);
        _failedController.add(null);
      }
    });
    _textController.listen((text) {
      if (text != null && text.isNotEmpty) {
        _failedController.add(null);
      }
    });
  }

  Stream<Task> get added => _addedController.stream;
  ValueObservable<String> get failed => _failedController.stream;
  Sink<String> get save => _saveController.sink;
  Sink<String> get updateText => _textController.sink;
  ValueObservable<String> get text => _textController.stream;

  @override
  void dispose() {
    _saveController.close();
    _addedController.close();
    _failedController.close();
    _textController.close();
  }
}
