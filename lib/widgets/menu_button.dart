import 'package:taskshare/bloc/account_provider.dart';
import 'package:taskshare/widgets/widgets.dart';
import 'package:taskshare/screens/setting.dart';

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountProvider.of(context);
    return StreamBuilder<FirebaseUser>(
      stream: accountBloc.user,
      builder: (context, snap) {
        if (!snap.hasData) {
          return AppProgressIndicator();
        }
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
