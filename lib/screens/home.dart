import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc_provider.dart';
import 'package:taskshare/screens/task/task_page_state.dart';
import 'package:taskshare/screens/task/task_screen.dart';
import 'package:taskshare/screens/welcome.dart';
import 'package:taskshare/widgets/widgets.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  const Home();

  factory Home.forDesignTime() => const Home();

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountBlocProvider.of(context);
    return StreamBuilder<AccountState>(
      initialData: accountBloc.state.value,
      stream: accountBloc.state,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case AccountState.loading:
            return const AppProgressIndicator();
          case AccountState.signedOut:
          case AccountState.signingIn:
            return const Welcome();
          case AccountState.signedIn:
          case AccountState.singingOut:
            return ScopedModel<TaskPageModel>(
              model: TaskPageModel(),
              child: TaskAdditionBlocProvider(
                child: const TaskScreen(),
              ),
            );
        }
        assert(false);
        return Container();
      },
    );
  }
}
