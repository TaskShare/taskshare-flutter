import 'package:taskshare/model/task.dart';
import '../export.dart';
void main() {
  test('TaskDecoder test', () {
    final data = {'title': 'title_test'};
    final decoder = new TaskDecoder();
    final task = decoder.decode('id', data);
    expect(new Task(id: 'id', title: 'title_test'), task);
  });
}
