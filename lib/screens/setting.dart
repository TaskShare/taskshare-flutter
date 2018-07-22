import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/model/account.dart';

class Setting extends StatelessWidget {
  static const routeName = "/settings";
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Account>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(model.user.toString()),
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
                    await model.signOut();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
      },
    );
  }
}
