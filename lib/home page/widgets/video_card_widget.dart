import 'dart:io';
import 'package:document_manager/details%20view%20page/view/video_detailed_view_page.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// ignore: must_be_immutable
class VideoCardWidget extends StatefulWidget {
DataModelHive dataModel;
  VideoCardWidget({
    super.key,required this.dataModel

  });

  @override
  State<VideoCardWidget> createState() => _VideoCardWidgetState();
}

class _VideoCardWidgetState extends State<VideoCardWidget> {
  String thumbnail = "";
  bool isLoading = true;
   int totalDaysToExpiry = 0;

  @override
  void initState() {
   
    super.initState();
    _generateThumbnail();
     calculateDaysBeforeExpiry(DateTime.now(), widget.dataModel.expiryDate);
  }

  Future<void> _generateThumbnail() async {
  
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: widget.dataModel.filePath!,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 75,
    );

    setState(() {
      thumbnail = thumbnailPath!;
      isLoading = false;
    });
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
            builder: (context) =>  VideoDetailedViewPage(dataModel: widget.dataModel),
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
                child: thumbnail.isEmpty
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
                          Icons.video_collection_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: widthMediaQuery * 0.4,
                        height: heightMediaQuery * 0.19,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(thumbnail)),
                              fit: BoxFit.cover),
                          color: const Color(0xff5C71F3),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
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
                      widget.dataModel. title,
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
