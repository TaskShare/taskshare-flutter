import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/bloc_provider.dart';
import 'package:taskshare/widgets/widgets.dart';

class Setting extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<FirebaseUser>(
      stream: accountBloc.user,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(user?.toString() ?? ''),
                ),
                Divider(
                  height: 1.0,
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
