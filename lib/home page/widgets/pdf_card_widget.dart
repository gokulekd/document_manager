import 'package:document_manager/constant/color.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';

import '../../details view page/view/document_detailed_view_page.dart';

// ignore: must_be_immutable
class PdfCardWidget extends StatefulWidget {
  DataModelHive dataModel;
  PdfCardWidget({
    super.key,
    required this.dataModel,
  });

  @override
  State<PdfCardWidget> createState() => _PdfCardWidgetState();
}

class _PdfCardWidgetState extends State<PdfCardWidget> {
  PdfPageImage? pdfImageFile;
  int totalDaysToExpiry = 0;
  @override
  void initState() {
    calculateDaysBeforeExpiry(DateTime.now(), widget.dataModel.expiryDate!);
    super.initState();
  }

  int calculateDaysBeforeExpiry(DateTime currentDate, DateTime expiryDate) {
    final difference = expiryDate.difference(currentDate);
    totalDaysToExpiry = difference.inDays;

    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    double widthMediaQuery = MediaQuery.of(context).size.width;
    double heightMediaQuery = MediaQuery.of(context).size.height;

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DocumentDetailedViewPage(dataModel: widget.dataModel),
          ),
        );
      },
      child: Container(
        // width: widthMediaQuery * 0.26,
        // height: heightMediaQuery * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 50),
          ],
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: pdfImageFile?.imageIfAvailable == null
                      ? Container(
                          width: widthMediaQuery * 0.4,
                          height: heightMediaQuery * 0.19,
                          decoration: const BoxDecoration(
                            color: Color(0xff5C71F3),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.picture_as_pdf,
                            size: 40,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: widthMediaQuery * 0.4,
                          height: heightMediaQuery * 0.19,
                          decoration: const BoxDecoration(
                            color: Color(0xff5C71F3),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Center(
                            // before using imageIfAvailable, you should call createImageIfNotAvailable
                            child: RawImage(
                                image: pdfImageFile!.imageIfAvailable,
                                fit: BoxFit.contain),
                          ))),
              SizedBox(
                height: widthMediaQuery * 0.21,
                width: heightMediaQuery * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dataModel.title,
                      textScaleFactor: 1.4,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:fadeBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.dataModel.documentType,
                      textScaleFactor: 1,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                     totalDaysToExpiry != 0
                        ? Text(
                            "Expiry in $totalDaysToExpiry days",
                            textScaleFactor: 1,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: totalDaysToExpiry < 30
                                    ? const Color.fromARGB(255, 199, 27, 27)
                                        .withOpacity(.7)
                                    : Colors.orange),
                          )
                        : const Text(
                            "No Expiry ",
                            textScaleFactor: 1,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
