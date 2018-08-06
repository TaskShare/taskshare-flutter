import 'package:taskshare/bloc/account_provider.dart';
import 'package:taskshare/widgets/widgets.dart';
import 'package:taskshare/screens/task_scaffold.dart';
import 'package:taskshare/screens/welcome.dart';

class Home extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountProvider.of(context);
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
            return TaskScaffold();
        }
        assert(false);
        return Container();
      },
    );
  }
}
