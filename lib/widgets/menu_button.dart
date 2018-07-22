import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/model/account.dart';
import 'package:taskshare/screens/setting.dart';

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Account>(builder: (context, child, model) {
      return IconButton(
        icon: ClipOval(
          child: Image.network(
            model.user.photoUrl,
            fit: BoxFit.cover,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Setting.routeName);
        },
      );
    });
  }
}
