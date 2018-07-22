import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/export/export_model.dart';
import 'package:taskshare/model/authenticator.dart';

enum AccountState { none, signedOut, signedIn }

// TODO: BloCにする
class Account extends Model {
  final Authenticator _googleAuth = GoogleAuthenticator();
  final _auth = FirebaseAuth.instance;
  AccountState state = AccountState.none;
  FirebaseUser user;

  Account() {
    _auth.onAuthStateChanged.listen((user) {
      log.info('onAuthStateChanged: $user');
      this.user = user;
      if (user == null) {
        state = AccountState.signedOut;
      } else {
        state = AccountState.signedIn;
      }
      notifyListeners();
    });
  }

  Future<FirebaseUser> signIn() async {
    assert(state == AccountState.signedOut);
    return await _googleAuth.signIn();
  }

  signOut() async {
    await _googleAuth.signOut();
  }
}
