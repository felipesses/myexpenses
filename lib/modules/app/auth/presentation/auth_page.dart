import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:myexpenses/modules/app/auth/presentation/controllers/auth_controller.dart';
import 'package:myexpenses/styles/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  final controller = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 50,
              child: SignInButton(
                Buttons.GoogleDark,
                onPressed: () {
                  controller.googleSignIn();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
