import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/bloc/account_bloc_provider.dart';
import 'package:taskshare/screens/setting.dart';
import 'package:taskshare/widgets/widgets.dart';

class MenuButton extends StatelessWidget {
  const MenuButton();

  factory MenuButton.forDesignTime() => MenuButton();

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountBlocProvider.of(context);
    return StreamBuilder<FirebaseUser>(
      stream: accountBloc.user,
      initialData: accountBloc.user.value,
      builder: (context, snap) {
        final user = snap.data;
        if (user == null) {
          return const AppProgressIndicator();
        }
        return IconButton(
          icon: ClipOval(
            child: Image.network(
              user.photoUrl,
              fit: BoxFit.cover,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Setting.routeName);
          },
        );
      },
    );
  }
}
