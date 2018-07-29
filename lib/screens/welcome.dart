import 'package:taskshare/bloc/account_provider.dart';
import 'package:taskshare/export/export_ui.dart';

class Welcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountProvider.of(context);
    return Scaffold(
      body: StreamBuilder(
        initialData: accountBloc.lastState,
        builder: (context, AsyncSnapshot<AccountState> snap) {
          return _buildBody(accountBloc);
        },
      ),
    );
  }

  Widget _buildBody(AccountBloc bloc) {
    final List<Widget> children = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('グループ共有に特化したタスク管理アプリです(　´･‿･｀)'),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text('Googleログイン'),
              onPressed: () {
                bloc.signIn();
              },
            )
          ],
        ),
      )
    ];
    if (bloc.lastState == AccountState.signingIn) {
      children.add(AppProgressIndicator(
        color: Colors.black.withAlpha(50),
      ));
    }
    return Stack(
      children: children,
    );
  }
}

