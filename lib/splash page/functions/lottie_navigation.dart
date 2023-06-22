import 'package:document_manager/home%20page/view/home_page_new.dart';
import 'package:flutter/material.dart';

navigate(context) async {
  await Future.delayed(
    const Duration(seconds: 4),
    () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageScreen(),
          ));
    },
  );
}