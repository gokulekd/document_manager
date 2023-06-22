import 'dart:io';
import 'package:document_manager/details%20view%20page/view/document_detailed_view_page.dart';
import 'package:document_manager/details%20view%20page/view/image_detailed_view_page.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class ImageCard extends StatefulWidget {
  DataModelHive modelData;
  ImageCard({super.key, required this.modelData});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  int totalDaysToExpiry = 0;
  @override
  void initState() {
    calculateDaysBeforeExpiry(DateTime.now(), widget.modelData.expiryDate!);
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
                DocumentDetailedViewPage(dataModel: widget.modelData,),
          ),
        );
      },
      child: Container(
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
                child: Container(
                  width: widthMediaQuery * 0.4,
                  height: heightMediaQuery * 0.19,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(widget.modelData.filePath!)),
                        fit: BoxFit.cover),
                    color: const Color(0xff5C71F3),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: widthMediaQuery * 0.21,
                width: heightMediaQuery * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.modelData.title,
                      textScaleFactor: 1.4,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.modelData.documentType,
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
