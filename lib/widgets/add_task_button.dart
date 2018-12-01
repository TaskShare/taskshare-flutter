import 'package:taskshare/bloc/task_addition_bloc.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/widgets/task_input.dart';
import 'package:taskshare/widgets/widgets.dart';

class AddTaskButton extends StatelessWidget {
  AddTaskButton();

  factory AddTaskButton.forDesignTime() => AddTaskButton();

  @override
  Widget build(BuildContext context) => Theme(
        // showModalBottomSheetの背景色をここだけ変えるためのWork Around
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: _AddTaskButton(),
      );
}

class _AddTaskButton extends StatefulWidget {
  @override
  _AddTaskButtonState createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<_AddTaskButton> {
  var _isInputting = false;
  TextEditingController _textController;
  TaskAdditionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _bloc = TaskAdditionBlocProvider.of(context);
    _bloc.fullscreenDemanded.listen((x) => Navigator.of(context).pop());
    _bloc.added.listen((task) {
      _textController.clear();
      Navigator.of(context).pop();
    });
    _bloc.failed.listen((error) {
      // TODO:
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isInputting) {
      return Container();
    }
    final l10n = L10N.of(context);
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text(l10n.addTask),
      onPressed: () async {
        setState(() {
          _isInputting = true;
        });
        await _showModalBottomSheet();
        await Future.delayed(Duration(milliseconds: 400));
        setState(() {
          _isInputting = false;
        });
      },
    );
  }

  Future _showModalBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            padding: MediaQuery.of(context).viewInsets,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TaskInput(
              textController: _textController,
            ),
          ),
    );
  }
}
