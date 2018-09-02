import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/bloc/account_bloc.dart';
import 'package:taskshare/bloc/bloc_provider.dart';
import 'package:taskshare/screens/setting.dart';
import 'package:taskshare/widgets/widgets.dart';

class MenuButton extends StatelessWidget {
  MenuButton();

  factory MenuButton.forDesignTime() => MenuButton();

  @override
  Widget build(BuildContext context) {
    final accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<FirebaseUser>(
      stream: accountBloc.user,
      builder: (context, snap) {
        if (!snap.hasData) {
          return AppProgressIndicator();
        }
        final user = snap.data;
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
