import 'dart:developer';

import 'package:document_manager/details%20view%20page/view/audio_detailed_view_page.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AudioCard extends StatefulWidget {
  DataModelHive data;
  int index;
  AudioCard({super.key, required this.data,required this.index});

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  int totalDaysToExpiry = 0;
  @override
  void initState() {
    calculateDaysBeforeExpiry(DateTime.now(), widget.data.expiryDate);
    super.initState();
  }

  int calculateDaysBeforeExpiry(DateTime currentDate, DateTime expiryDate) {
    final difference = expiryDate.difference(currentDate);
    totalDaysToExpiry = difference.inDays;
    log(totalDaysToExpiry.toString());
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
            builder: (context) => AudioDetailedViewPage(dataModel: widget.data,index:widget.index ),
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
                child: Container(
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
                      Icons.music_note_outlined,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: widthMediaQuery * 0.21,
                width: heightMediaQuery * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
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
                      widget.data.documentType,
                      textScaleFactor: 1,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                    Text(
                      "Expiry in $totalDaysToExpiry days",
                      textScaleFactor: 1,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: totalDaysToExpiry < 30
                              ? const Color.fromARGB(255, 199, 27, 27)
                                  .withOpacity(.7)
                              : Colors.green),
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
