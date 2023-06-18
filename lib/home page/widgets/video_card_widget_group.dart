import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:document_manager/home%20page/widgets/video_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';

class VideoCardWidgetGroup extends StatefulWidget {
  const VideoCardWidgetGroup({super.key});

  @override
  State<VideoCardWidgetGroup> createState() => _VideoCardWidgetGroupState();
}

class _VideoCardWidgetGroupState extends State<VideoCardWidgetGroup> {
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

    await getVideoDataFromHive();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: videoDataNotifier,
        builder:
            (BuildContext ctx, List<DataModelHive> videoData, Widget? child) {
          return GridView.builder(
           
              shrinkWrap: true,
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: videoData.length,
              itemBuilder: (BuildContext ctx, index) {
                final data = videoData[index];
                return VideoCardWidget(
                  dataModel: data,
                );
              });
        });
  }
}
