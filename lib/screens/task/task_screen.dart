import 'package:flutter/material.dart';
import 'package:taskshare/screens/task/add_task_button.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc_provider.dart';
import 'package:taskshare/screens/task/addition/task_input.dart';
import 'package:taskshare/screens/task/bottom_menu.dart';
import 'package:taskshare/screens/task/list/task_list.dart';
import 'package:taskshare/screens/task/menu_button.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  TaskAdditionBloc _bloc;
  TaskScreenMode _mode;
  Animation<double> _backgroundFadeAnimation;
  Animation<double> _fabFadeAnimation;
  Animation<double> _reverseInputViewFadeAnimation;
  AnimationController _animationController;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _backgroundFadeAnimation =
        Tween<double>(begin: 0, end: 0.4).animate(_animationController);
    _fabFadeAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.4),
    ));
    _reverseInputViewFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1),
    ));
    _bloc = TaskAdditionBlocProvider.of(context);
    _mode = _bloc.screenMode.value;

    // フルスクリーン画面が無いのでとりあえず閉じるだけ
    _bloc.fullscreenDemanded.listen((x) => _updateMode(TaskScreenMode.list));

    _bloc.added.listen((task) {
      _bloc.updateScreenMode.add(TaskScreenMode.list);
      _textController.clear();
    });

    _textController.addListener(() {
      _bloc.updateText.add(_textController.text);
    });

    _bloc.screenMode.listen(_updateMode);
  }

  void _updateMode(TaskScreenMode mode) async {
    if (mode == _mode) {
      return;
    }
    switch (mode) {
      case TaskScreenMode.input:
        setState(() => _mode = mode);
        _animationController.forward();
        break;
      case TaskScreenMode.list:
        FocusScope.of(context).requestFocus(FocusNode());
        await _animationController.reverse(); //from: 1);
        setState(() => _mode = mode);
        break;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final main = Scaffold(
      bottomNavigationBar: const BottomMenu(),
      appBar: _buildAppBar(),
      body: const TaskList(),
      floatingActionButton: FadeTransition(
        child: const AddTaskButton(),
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
                  child: FadeTransition(
                    opacity: _backgroundFadeAnimation,
                    child: Container(color: Colors.black),
                  ),
                ),
                Positioned.fill(
                  top: null,
                  child: Padding(
                    padding: minInsets,
                    child: Material(
                      color: Colors.transparent,
                      child: FadeTransition(
                        opacity: _reverseInputViewFadeAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: TaskInput(
                            textController: _textController,
                          ),
                        ),
                      ),
                    ),
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
        title: const Text('TaskShare'),
        actions: const [MenuButton()],
      );
}