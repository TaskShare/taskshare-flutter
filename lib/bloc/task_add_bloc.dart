import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class TaskAddBloc implements Bloc {
  final _subject = BehaviorSubject<String>();

  ValueObservable<String> get stream => _subject.stream;
  Sink<String> get update => _subject.sink;

  @override
  void dispose() {
    _subject.close();
  }
}
