import 'package:cloud_firestore/cloud_firestore.dart';
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
      'doneTime': Timestamp.fromDate(DateTime(2000)),
      'dueTime': Timestamp.fromDate(DateTime(2001)),
      'createTime': Timestamp.fromDate(DateTime(2002)),
      'updateTime': Timestamp.fromDate(DateTime(2003))
    };
    final decoder = TaskDecoder();
    final task = decoder.decode(data);
    expect(
      isSame(
        task,
        Task(
          id: 'id_test',
          title: 'title_test',
          doneTime: Timestamp.fromDate(DateTime(2000)),
          dueTime: Timestamp.fromDate(DateTime(2001)),
          createTime: Timestamp.fromDate(DateTime(2002)),
          updateTime: Timestamp.fromDate(DateTime(2003)),
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
        doneTime: Timestamp.fromDate(DateTime(2000)),
        dueTime: Timestamp.fromDate(DateTime(2001)),
        createTime: Timestamp.fromDate(DateTime(2002)),
        updateTime: Timestamp.fromDate(DateTime(2003))));
    expect(
      {
        'id': 'id_test',
        'title': 'title_test',
        'doneTime': Timestamp.fromDate(DateTime(2000)),
        'dueTime': Timestamp.fromDate(DateTime(2001)),
        'createTime': Timestamp.fromDate(DateTime(2002)),
        'updateTime': Timestamp.fromDate(DateTime(2003))
      },
      data,
    );
  });
}
