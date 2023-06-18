import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPageView extends StatelessWidget {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Lottie.asset("assets/splash_screen_animation.json")],
      ),
    );
  }
}
