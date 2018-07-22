import 'package:taskshare/export/export_ui.dart';
import 'package:taskshare/model/account.dart';
import 'package:taskshare/screens/task.dart';
import 'package:taskshare/screens/welcome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Account>(
      builder: (context, child, model) {
        switch (model.state) {
          case AccountState.none:
            return AppProgressIndicator();
          case AccountState.signedOut:
            return Welcome();
          case AccountState.signedIn:
            return MyTask();
        }
        assert(false);
        return Container();
      },
    );
  }
}
