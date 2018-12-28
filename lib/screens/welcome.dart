import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class Welcome extends StatelessWidget {
  const Welcome();

  factory Welcome.forDesignTime() => const Welcome();

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountBlocProvider.of(context);
    final body = StreamBuilder<AccountState>(
      initialData: accountBloc.state.value,
      stream: accountBloc.state,
      builder: (context, snap) {
        final children = <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('グループ共有に特化したタスク管理アプリです(　´･‿･｀)'),
                const SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  child: const Text('Googleログイン'),
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
