import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';
import 'image_card_widget.dart';

class ImageCardWidgetGroup extends StatefulWidget {
  const ImageCardWidgetGroup({super.key});

  @override
  State<ImageCardWidgetGroup> createState() => _ImageCardWidgetGroupState();
}

class _ImageCardWidgetGroupState extends State<ImageCardWidgetGroup> {
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

    await getImageDataFromHive();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator.adaptive())
        : ValueListenableBuilder(
            valueListenable: imageDataNotifier,
            builder: (BuildContext ctx, List<DataModelHive> imageData,
                Widget? child) {
              return GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: imageData.length,
                itemBuilder: (BuildContext ctx, index) {
                  final imageDataModel = imageData[index];

                  return ImageCard(
                    modelData: imageDataModel,
                  );
                },
              );
            },
          );
  }
}
