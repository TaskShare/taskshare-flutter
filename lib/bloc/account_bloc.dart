import 'package:taskshare/export/export_model.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AccountState { loading, signedOut, signedIn, signingIn, singingOut }

class AccountBloc {
  AccountBloc() {
    _auth.onAuthStateChanged.map((user) {
      log.info('onAuthStateChanged: $user');
      _state.add(user == null ? AccountState.signedOut : AccountState.signedIn);
      return user;
    }).pipe(_user);

    _signInController.stream.listen((_) {
      assert(lastState == AccountState.signedOut);
      _state.add(AccountState.signingIn);
      _googleAuth.signIn();
    });

    _signOutController.stream.listen((_) {
      assert(lastState == AccountState.signedIn);
      _state.add(AccountState.singingOut);
      _googleAuth.signOut();
    });
  }
  final Authenticator _googleAuth = GoogleAuthenticator();
  final _auth = FirebaseAuth.instance;

  final _user = BehaviorSubject<FirebaseUser>();
  Observable<FirebaseUser> get user => _user.stream;
  FirebaseUser get lastUser => _user.value;

  final _state = BehaviorSubject<AccountState>(seedValue: AccountState.loading);
  Observable<AccountState> get state => _state.stream;
  AccountState get lastState => _state.value;

  final _signInController = StreamController<void>();
  Sink<void> get signIn => _signInController.sink;

  final _signOutController = StreamController<void>();
  Sink<void> get signOut => _signOutController.sink;


  dispose() {
    _user.close();
    _signInController.close();
    _signOutController.close();
  }
}
