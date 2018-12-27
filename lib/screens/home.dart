import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/screens/task/addition/task_addition_bloc_provider.dart';
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
      initialData: AccountState.loading,
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
            return TaskAdditionBlocProvider(child: TaskScreen());
        }
        assert(false);
        return Container();
      },
    );
  }
}
