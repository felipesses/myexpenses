import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myexpenses/core/auth/auth.dart';
import 'package:myexpenses/core/auth/errors.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final Auth auth = Auth();
  final _auth = FirebaseAuth.instance;

  @action
  getUser() {
    User? user = _auth.currentUser;

    if (user != null) return user.uid;
  }

  @action
  googleSignIn() async {
    await auth.googleSignIn().then((status) => {
          if (status == AuthResultStatus.successful)
            {
              Modular.to.navigate(
                '/home',
                arguments: DateTime.now().millisecondsSinceEpoch,
              )
            }
        });
  }
}
