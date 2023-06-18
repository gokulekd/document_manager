
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:document_manager/home%20page/widgets/pdf_card_widget.dart';
import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';
import 'package:flutter/material.dart';

class PdfCardWidgetGroup extends StatefulWidget {
  const PdfCardWidgetGroup({super.key});

  @override
  State<PdfCardWidgetGroup> createState() => _PdfCardWidgetGroupState();
}

class _PdfCardWidgetGroupState extends State<PdfCardWidgetGroup> {
  bool isLoading = true;

  @override
  void initState() {
    getPageData();
    super.initState();
  }

  getPageData() async {
    setState(() {
      isLoading = true;
    });

    await getPdfDataFromHive();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ValueListenableBuilder(
            valueListenable: pdfDataNotifier,
            builder:
                (BuildContext ctx, List<DataModelHive> pdfData, Widget? child) {
              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: pdfData.length,
                itemBuilder: (BuildContext ctx, index) {
                  final data = pdfData[index];
                  return PdfCardWidget(
                    dataModel: data,
                  );
                },
              );
            },
          );
  }
}
