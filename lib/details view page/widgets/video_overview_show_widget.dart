import 'dart:io';
import 'package:document_manager/over%20view/view/video_player_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// ignore: must_be_immutable
class VideoOverviewMainWidget extends StatefulWidget {
  String title;
  String filePath;
  String documentType;

  VideoOverviewMainWidget({
    required this.documentType,
    required this.filePath,
    required this.title,
    super.key,
  });

  @override
  State<VideoOverviewMainWidget> createState() =>
      _VideoOverviewMainWidgetState();
}

class _VideoOverviewMainWidgetState extends State<VideoOverviewMainWidget> {
  String thumbnail = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    setState(() {
      isLoading = true;
    });
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: widget.filePath,
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerWidget(videoUrl: widget.filePath),
            ));
        // O
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: !isLoading
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(thumbnail),
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff5C71F3),
                                ),
                                child: const Icon(
                                  Icons.play_circle_outline_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff5C71F3),
                                ),
                                child: const Icon(
                                  Icons.play_circle_outline_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.48,
                              child: Text(
                                widget.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                widget.documentType,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // ElevatedButton.icon(
                            //     onPressed: () {},
                            //     icon: const Icon(Icons.edit),
                            //     label: const Text("Edit"))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.navigate_next_outlined,
                          size: 40,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
