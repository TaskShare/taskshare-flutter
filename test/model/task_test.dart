import 'package:taskshare/model/task.dart';

import '../test.dart';

bool isSame(Task a, Task b) {
  return a == b &&
      a.title == b.title &&
      a.doneTime == b.doneTime &&
      a.dueTime == b.dueTime &&
      a.createTime == b.createTime &&
      a.updateTime == b.updateTime;
}

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
      isSame(
        task,
        Task(
          id: 'id_test',
          title: 'title_test',
          doneTime: DateTime(2000),
          dueTime: DateTime(2001),
          createTime: DateTime(2002),
          updateTime: DateTime(2003),
        ),
      ),
      true,
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
