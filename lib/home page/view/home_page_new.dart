import 'dart:developer';

import 'package:document_manager/add%20document/view/add_document_page.dart';
import 'package:document_manager/home%20page/widgets/audio_card_widget_group.dart';
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
  }

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
        backgroundColor: const Color(0xffF8F9FB),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            leading: const SizedBox(),
            elevation: 20,
            shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
            backgroundColor: Colors.white,
            title: Text(
              'Document manger',
             
              style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 48, 54, 174),
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddDocumentPage(),
                          ));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add new file")),
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.black.withOpacity(.8),
              unselectedLabelStyle:
                  TextStyle(color: Colors.black.withOpacity(.5)),
              unselectedLabelColor: Colors.black.withOpacity(.4),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black.withOpacity(.8),
              tabs: const [
                Tab(
                  child: Text(
                    'audio',
                  ),
                ),
                Tab(
                  child: Text(
                    'video',
                  ),
                ),
                Tab(
                  child: Text(
                    'pdf',
                  ),
                ),
                Tab(
                  child: Text(
                    'images',
                  ),
                ),
              ],
            ),
          ),
        ),
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
}
