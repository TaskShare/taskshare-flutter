import 'package:taskshare/model/task.dart';
import '../test.dart';

void main() {
  test('TaskDecoder test', () {
    final data = {
      'id': 'id_test',
      'title': 'title_test',
      'doneTime': DateTime(2000),
      'dueTime': DateTime(2001),
      'createTime': DateTime(2002),
      'updateTime': DateTime(2003)
    };
    final decoder = TaskDecoder();
    final task = decoder.decode(data);
    expect(
      Task(
          id: 'id_test',
          title: 'title_test',
          doneTime: DateTime(2000),
          dueTime: DateTime(2001),
          createTime: DateTime(2002),
          updateTime: DateTime(2003)),
      task,
    );
  });

  test('TaskEncoder test', () {
    final encoder = TaskEncoder();
    final data = encoder.encode(Task(
        id: 'id_test',
        title: 'title_test',
        doneTime: DateTime(2000),
        dueTime: DateTime(2001),
        createTime: DateTime(2002),
        updateTime: DateTime(2003)));
    expect(
      {
        'id': 'id_test',
        'title': 'title_test',
        'doneTime': DateTime(2000),
        'dueTime': DateTime(2001),
        'createTime': DateTime(2002),
        'updateTime': DateTime(2003)
      },
      data,
    );
  });
}
