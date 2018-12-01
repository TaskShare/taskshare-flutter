import 'package:bloc_provider/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/model.dart';

export 'package:taskshare/model/authenticator.dart';

class AccountBloc implements Bloc {
  AccountBloc({@required this.authenticator}) {
    _signInController.stream.listen((_) {
      authenticator.signIn();
    });

    _signOutController.stream.listen((_) {
      authenticator.signOut();
    });
  }

  ValueObservable<FirebaseUser> get user => authenticator.user;

  Observable<AccountState> get state => authenticator.state;

  Sink<void> get signIn => _signInController.sink;

  Sink<void> get signOut => _signOutController.sink;

  final Authenticator authenticator;

  final _signInController = StreamController<void>();

  final _signOutController = StreamController<void>();

  @override
  void dispose() {
    _signInController.close();
    _signOutController.close();
  }
}
