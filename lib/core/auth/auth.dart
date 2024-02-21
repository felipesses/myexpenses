import 'package:firebase_auth/firebase_auth.dart';

import './errors.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResultStatus> googleSignIn() async {
    AuthResultStatus status = AuthResultStatus.undefined;

    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      final credential = await _auth.signInWithPopup(googleProvider);
      final user = credential.user;

      if (user != null) {
        status = AuthResultStatus.successful;
      }
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleException(e);
    }

    return status;
  }
}
