import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myexpenses/modules/app/presentation/controllers/app_controller.dart';
import 'package:myexpenses/styles/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final controller = Modular.get<AppController>();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    Future.delayed(
      const Duration(milliseconds: 1200),
      () {
        controller.setMonth();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Hero(
          tag: "logo",
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.fill,
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
