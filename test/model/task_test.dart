import 'package:taskshare/model/task.dart';
import '../export.dart';

void main() {
  test('TaskDecoder test', () {
    final data = {
      'id': 'id_test',
      'title': 'title_test',
    };
    final decoder = new TaskDecoder();
    final task = decoder.decode(data);
    expect(
        new Task(
          id: 'id_test',
          title: 'title_test',
        ),
        task);
  });

  test('TaskEncoder test', () {
    final encoder = new TaskEncoder();
    final data = encoder.encode(new Task(
      id: 'id_test',
      title: 'title_test',
    ));
    expect({
      'id': 'id_test',
      'title': 'title_test',
    }, data);
  });
}
