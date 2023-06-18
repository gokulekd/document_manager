import 'dart:developer';

import 'package:document_manager/details%20view%20page/widgets/pdf_details_show_widget.dart';
import 'package:document_manager/details%20view%20page/widgets/pdf_overview_main_widget.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PdfDetailedViewPage extends StatefulWidget {
  DataModelHive dataModel;
  PdfDetailedViewPage({super.key, required this.dataModel});

  @override
  State<PdfDetailedViewPage> createState() => _PdfDetailedViewPageState();
}

class _PdfDetailedViewPageState extends State<PdfDetailedViewPage> {
  @override
  void initState() {
    formatFileSize();
    super.initState();
  }

  String documentSize = '';

  formatFileSize() {
    double fileSizeInMB =
        widget.dataModel.fileSize / 100000; // Convert KB to MB
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
              child: PdfOverviewMainWidget(
                  filePath: widget.dataModel.filePath!,
                  heightMediaQuery: height,
                  widthMediaQuery: width,
                  documentType: widget.dataModel.documentType,
                  title: widget.dataModel.title),
            ),
            PdfDetailsShowWidget(
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
                // overflow: TextOverflow.ellipsis,
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
