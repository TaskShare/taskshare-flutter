import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/util/app_logger.dart';

enum AccountState {
  none,
  signedOut,
  signedIn
}

class AccountModel extends Model {

  final Authenticator _googleAuth = GoogleAuthenticator();
  final _auth = FirebaseAuth.instance;
  AccountState state = AccountState.none;
  FirebaseUser user;

  AccountModel() {
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