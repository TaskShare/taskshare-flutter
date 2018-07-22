import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/model/account.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  bool _isLogginedIn = false;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Account>(builder: (context, child, model) {
      return Scaffold(
        body: _buildBody(model),
      );
    });
  }

  Widget _buildBody(Account model) {
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
              onPressed: () async {
                setState(() {
                  _isLogginedIn = true;
                });
                setState(() {
                  _isLogginedIn;
                });
                // TODO: リファクタリング
                FirebaseUser user;
                try {
                  user = await model.signIn();
                } catch (error) {
                  log.warning(error);
                }
                log.info('user: $user');
                setState(() {
                  _isLogginedIn = false;
                });
              },
            )
          ],
        ),
      )
    ];
    if (_isLogginedIn) {
      children.add(AppProgressIndicator(
        color: Colors.black.withAlpha(50),
      ));
    }
    return Stack(
      children: children,
    );
  }
}
