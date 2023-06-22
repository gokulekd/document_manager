import 'dart:developer';
import 'package:document_manager/details%20view%20page/widgets/video_details_show_widget.dart';
import 'package:document_manager/details%20view%20page/widgets/video_overview_show_widget.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VideoDetailedViewPage extends StatefulWidget {
  DataModelHive dataModel;
  VideoDetailedViewPage({super.key, required this.dataModel});

  @override
  State<VideoDetailedViewPage> createState() => _VideoDetailedViewPageState();
}

class _VideoDetailedViewPageState extends State<VideoDetailedViewPage> {
  @override
  void initState() {
    formatFileSize();
    super.initState();
  }

  String documentSize = '';

  formatFileSize() {
    double fileSizeInMB =
        widget.dataModel.fileSize / 100000; 
    setState(() {
      documentSize = fileSizeInMB.toStringAsFixed(1);
      log("document Size is ${widget.dataModel.fileSize}");
      log("converted Size is $documentSize");
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
        backgroundColor: Colors.white,
        title: Text(
          'Overview',
          textScaleFactor: 1.12,
          style: TextStyle(
            color: Colors.black.withOpacity(.7),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: VideoOverviewMainWidget(
                  filePath: widget.dataModel.filePath!,
           
                  documentType: widget.dataModel.documentType,
                  title: widget.dataModel.title),
            ),
            VideoDetailsShowWidget(
                width: width, data: widget.dataModel, fileSize: documentSize),
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 14),
              child: Center(
                child: Text(
                  "Description",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 14),
              child: Text(
                widget.dataModel.description,
              
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
