import 'package:taskshare/bloc/account_provider.dart';
import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/screens/setting.dart';

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountProvider.of(context);
    return StreamBuilder<FirebaseUser>(
      initialData: accountBloc.lastUser,
      stream: accountBloc.user,
      builder: (context, snap) {
        final user = snap.data;
        return IconButton(
          icon: ClipOval(
            child: CachedNetworkImage(
              imageUrl: user.photoUrl,
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
