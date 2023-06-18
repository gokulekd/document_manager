import 'package:document_manager/home%20page/view/home_page_new.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPageView extends StatelessWidget {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      body: ListView(
        children: [
          Lottie.asset(repeat: false,
            "assets/splash_screen_animation.json",
          )
        ],
      ),
    );
  }
}

navigate(context)async {
 await Future.delayed(const Duration(seconds: 4),() {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageScreen(),
      ));
  },);

}
