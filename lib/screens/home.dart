import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/bloc/task_addtion_bloc_provider.dart';
import 'package:taskshare/screens/task_screen.dart';
import 'package:taskshare/screens/welcome.dart';
import 'package:taskshare/widgets/widgets.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  Home();

  factory Home.forDesignTime() => Home();

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountBlocProvider.of(context);
    return StreamBuilder<AccountState>(
      initialData: AccountState.loading,
      stream: accountBloc.state,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case AccountState.loading:
            return AppProgressIndicator();
          case AccountState.signedOut:
          case AccountState.signingIn:
            return Welcome();
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
