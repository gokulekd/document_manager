import 'package:document_manager/constant/file.dart';
import 'package:document_manager/home%20page/view/home_page_new.dart';
import 'package:document_manager/splash%20page/functions/lottie_navigation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPageView extends StatelessWidget {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      body: ListView(
        children: [Lottie.asset(repeat: false, lottieFile)],
      ),
    );
  }
}
