import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class Setting extends StatelessWidget {
  const Setting();

  factory Setting.forDesignTime() => const Setting();
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountBlocProvider.of(context);
    return StreamBuilder<User>(
      initialData: accountBloc.user.value,
      stream: accountBloc.user,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(user?.toString() ?? ''),
                ),
                const Divider(
                  height: 1,
                ),
                ListTile(
                  title: Text(
                    'Sign out',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                  onTap: () async {
                    accountBloc.signOut.add(null);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
      },
    );
  }
}
