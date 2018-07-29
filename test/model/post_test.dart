import 'package:taskshare/model/task.dart';
import '../export.dart';
void main() {
  test('TaskDecoder test', () {
    final data = {'title': 'title_test'};
    final decoder = new TaskDecoder();
    final task = decoder.decode('id', data);
    expect('id', task.id);
    expect('title_test', task.title);
  });
}
