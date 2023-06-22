import 'dart:io';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageOverView extends StatelessWidget {
  String filePath;
  ImageOverView({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height*0.95,
            width: MediaQuery.of(context).size.width*0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: FileImage(File(filePath)), fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
