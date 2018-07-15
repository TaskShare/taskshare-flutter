import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Authenticator {
  Future<FirebaseUser> signIn();
  signOut();
}

class GoogleAuthenticator implements Authenticator {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = new GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  Future<FirebaseUser> signIn() async {
    final gAccount = await _googleSignIn.signIn();
    final gAuth = await gAccount.authentication;
    final firUser = _auth.signInWithGoogle(
      idToken: gAuth.idToken,
      accessToken: gAuth.accessToken,
    );
    print(firUser);
    return firUser;
  }

  signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
