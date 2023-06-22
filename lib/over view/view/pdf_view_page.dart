import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerSampleWidget extends StatelessWidget {
  final String filePath;

  const PDFViewerSampleWidget({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      // ignore: avoid_unnecessary_containers
      body: SafeArea(child: Container(child: SfPdfViewer.file(File(filePath)))),
    );
  }
}
