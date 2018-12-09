import 'package:taskshare/bloc/task_addition_bloc.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/widgets/add_task_button.dart';
import 'package:taskshare/widgets/bottom_menu.dart';
import 'package:taskshare/widgets/menu_button.dart';
import 'package:taskshare/widgets/task_input.dart';
import 'package:taskshare/widgets/task_list.dart';
import 'package:taskshare/widgets/widgets.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() {
    return new TaskScreenState();
  }
}

// TODO: fade animation
// 閉じる時は下のビューもフェードアウトしてほしい
class TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  TaskAdditionBloc _bloc;
  TaskScreenMode _mode;
  Animation<double> _animation;
  Animation<double> _fabFadeAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            // TODO: リファクター
            setState(() {});
          });
    _animation =
        Tween<double>(begin: 0, end: 100).animate(_animationController);
    _fabFadeAnimation =
        Tween<double>(begin: 1, end: 0).animate(_animationController);
    _bloc = TaskAdditionBlocProvider.of(context);
    _mode = _bloc.screenMode.value;
    _bloc.fullscreenDemanded.listen((x) => Navigator.of(context).pop());
    _bloc.added.listen((task) {
      _bloc.updateScreenMode.add(TaskScreenMode.list);
    });
    _bloc.failed.listen((error) {
      // TODO:
    });
    _bloc.screenMode.listen((toMode) async {
      if (toMode == _mode) {
        return;
      }
      switch (toMode) {
        case TaskScreenMode.input:
          setState(() => _mode = toMode);
          _animationController.forward();
          break;
        case TaskScreenMode.list:
          FocusScope.of(context).requestFocus(FocusNode());
          await _animationController.reverse(); //from: 1);
          setState(() => _mode = toMode);
          break;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final main = Scaffold(
      bottomNavigationBar: BottomMenu(),
      appBar: _buildAppBar(),
      body: TaskList(),
      floatingActionButton: FadeTransition(
        child: AddTaskButton(),
        opacity: _fabFadeAnimation,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    switch (_mode) {
      case TaskScreenMode.list:
        return main;
      case TaskScreenMode.input:
        final mediaQuery = MediaQuery.of(context);
        final EdgeInsets minInsets =
            mediaQuery.padding.copyWith(bottom: mediaQuery.viewInsets.bottom);
        return Stack(
          children: [
            main,
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _bloc.updateScreenMode.add(TaskScreenMode.list),
                  child: Container(
                    color: Colors.black.withAlpha(_animation.value.toInt()),
                  ),
                ),
                Padding(
                  padding: minInsets,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: TaskInput(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
    }
    assert(false);
    return null;
  }

  AppBar _buildAppBar() => AppBar(
        title: Text('TaskShare'),
        actions: [MenuButton()],
      );
}
