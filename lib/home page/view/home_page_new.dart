import 'dart:developer';

import 'package:document_manager/home%20page/widgets/audio_card_widget_group.dart';
import 'package:document_manager/home%20page/widgets/home_page_app_bar.dart';
import 'package:document_manager/home%20page/widgets/image_card_widget_group.dart';
import 'package:document_manager/home%20page/widgets/pdf_card_widget_group.dart';
import 'package:document_manager/home%20page/widgets/video_card_widget_group.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    checkPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: homePageAppBar(context),
        body: const TabBarView(
          children: [
            AudioCardWidgetGroup(),
            VideoCardWidgetGroup(),
            PdfCardWidgetGroup(),
            ImageCardWidgetGroup(),
          ],
        ),
      ),
    );
  }


  Future<void> checkPermissionStatus() async {
    final status = await Permission.storage.status;
    setState(() {
      _permissionStatus = status;
    });
    log(_permissionStatus.toString());
    if (_permissionStatus == PermissionStatus.denied) {
      requestPermission();
    }
  }

  Future<void> requestPermission() async {
    log("request called");
    final status = await Permission.storage.request();
    setState(() {
      _permissionStatus = status;
    });
    log(_permissionStatus.toString());

    if (_permissionStatus == PermissionStatus.denied ||
        _permissionStatus.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: () async {
        Navigator.pop(context);
        final status = await Permission.storage.request();
        setState(() {
          _permissionStatus = status;
        });
      },
      child: const Text("back"),
    );
    Widget continueButton = TextButton(
        onPressed: () {
          openAppSettings();
          Navigator.pop(context);
        },
        child: const Text("Go to Settings"));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text(
          "To change the permission settings,you fist have to turn on the storage permission in the app settings"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
