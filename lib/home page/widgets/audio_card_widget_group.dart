import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:document_manager/home%20page/widgets/audio_card_widget.dart';
import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';
import 'package:document_manager/home%20page/widgets/image_card_widget.dart';
import 'package:document_manager/home%20page/widgets/pdf_card_widget.dart';
import 'package:document_manager/home%20page/widgets/video_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class AudioCardWidgetGroup extends StatefulWidget {
  String dataType;
  AudioCardWidgetGroup({super.key, required this.dataType});

  @override
  State<AudioCardWidgetGroup> createState() => _AudioCardWidgetGroupState();
}

class _AudioCardWidgetGroupState extends State<AudioCardWidgetGroup> {
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

    // await getMp3DataFromHive();
  await  getVideoDataFromHive();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget myWidget(
      {required String dataType, required DataModelHive data, required int index}) {
    if (widget.dataType == "audioData") {
     return AudioCard(data: data, index: 1);
    } else if (widget.dataType == "videoData") {
     return VideoCardWidget(dataModel: data);
    } else if (widget.dataType == "documentData") {
     return ImageCard(modelData: data);
    } else if (widget.dataType == "imageData") {
    return  PdfCardWidget(dataModel: data);
    }

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ValueListenableBuilder(
            valueListenable:
                Hive.box<DataModelHive>(widget.dataType).listenable(),
            builder:
                (BuildContext ctx, Box<DataModelHive> value, Widget? child) {
              final data = value.values.toList();

              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: data.length,
                itemBuilder: (BuildContext ctx, index) {
                  return myWidget(
                      dataType: widget.dataType, data: data[index], index: index);
                },
              );
            });
  }
}
