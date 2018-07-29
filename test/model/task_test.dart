import 'package:taskshare/model/task.dart';
import '../export.dart';

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
    final decoder = new TaskDecoder();
    final task = decoder.decode(data);
    expect(
      new Task(
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
    final encoder = new TaskEncoder();
    final data = encoder.encode(new Task(
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
