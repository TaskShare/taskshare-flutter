import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

export 'package:scoped_model/scoped_model.dart';

enum TaskScreenMode { list, input, fullscreen }

class TaskPageModel extends Model {
  var _mode = TaskScreenMode.list;
  TaskScreenMode get mode => _mode;

  void update({TaskScreenMode mode}) {
    _mode = mode;
    notifyListeners();
  }

  static TaskPageModel of(
    BuildContext context, {
    bool rebuildOnChange = false,
  }) =>
      ScopedModel.of<TaskPageModel>(
        context,
        rebuildOnChange: rebuildOnChange,
      );
}
