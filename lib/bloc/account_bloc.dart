import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskshare/bloc/BlocProvider.dart';
import 'package:taskshare/model/authenticator.dart';
import 'package:taskshare/model/model.dart';

export 'package:taskshare/model/authenticator.dart';

class AccountBloc implements BlocBase {
  AccountBloc({@required this.authenticator}) {
    _signInController.stream.listen((_) {
      authenticator.signIn();
    });

    _signOutController.stream.listen((_) {
      authenticator.signOut();
    });
  }

  Observable<FirebaseUser> get user => authenticator.user;

  Observable<AccountState> get state => authenticator.state;

  Sink<void> get signIn => _signInController.sink;

  Sink<void> get signOut => _signOutController.sink;

  final Authenticator authenticator;

  final _signInController = StreamController<void>();

  final _signOutController = StreamController<void>();

  // TODO: call
  @override
  dispose() {
    _signInController.close();
    _signOutController.close();
  }
}
