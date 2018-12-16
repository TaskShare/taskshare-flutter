import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskshare/model/model.dart';

enum AccountState { loading, signedOut, signedIn, signingIn, singingOut }

abstract class Authenticator {
  ValueObservable<FirebaseUser> get user;

  Observable<AccountState> get state;

  Future<FirebaseUser> signIn();

  Future<void> signOut();
}

class GoogleAuthenticator implements Authenticator {
  GoogleAuthenticator() {
    _auth.onAuthStateChanged.map((user) {
      log.info('onAuthStateChanged: $user');
      _state.add(user == null ? AccountState.signedOut : AccountState.signedIn);
      return user;
    }).pipe(_user);
  }

  @override
  ValueObservable<FirebaseUser> get user => _user.stream;

  @override
  Observable<AccountState> get state => _state.stream;
  final _user = BehaviorSubject<FirebaseUser>();

  final _state = BehaviorSubject<AccountState>(seedValue: AccountState.loading);

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  @override
  Future<FirebaseUser> signIn() async {
    assert(_state.value == AccountState.signedOut);
    _state.add(AccountState.signingIn);
    final gAccount = await _googleSignIn.signIn();
    final gAuth = await gAccount.authentication;
    final firUser = _auth.signInWithGoogle(
      idToken: gAuth.idToken,
      accessToken: gAuth.accessToken,
    );
    log.info(firUser);
    return firUser;
  }

  @override
  Future<void> signOut() async {
    assert(_state.value == AccountState.signedIn);
    _state.add(AccountState.singingOut);
    // TEMP: 本当は呼ぶけど開発中はコメントアウト
//    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  void dispose() {
    _user.close();
    _state.close();
  }
}
