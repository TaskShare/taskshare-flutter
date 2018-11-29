import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class Welcome extends StatelessWidget {
  Welcome();

  factory Welcome.forDesignTime() => Welcome();

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountBlocProvider.of(context);
    final body = StreamBuilder<AccountState>(
      initialData: AccountState.loading,
      stream: accountBloc.state,
      builder: (context, snap) {
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
                    accountBloc.signIn.add(null);
                  },
                )
              ],
            ),
          )
        ];
        if (snap.data == AccountState.signingIn) {
          children.add(AppProgressIndicator(
            color: Theme.of(context).backgroundColor.withAlpha(50),
          ));
        }
        return Stack(
          children: children,
        );
      },
    );

    return Scaffold(
      body: body,
    );
  }
}
