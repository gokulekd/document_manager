import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:document_manager/home%20page/widgets/audio_card_widget.dart';
import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';
import 'package:flutter/material.dart';

class AudioCardWidgetGroup extends StatefulWidget {
  const AudioCardWidgetGroup({super.key});

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

    await getMp3DataFromHive();

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
            valueListenable: mp3DataNotifier,
            builder:
                (BuildContext ctx, List<DataModelHive> mp3Data, Widget? child) {
              return GridView.builder(
            
                shrinkWrap: true,
                padding: const EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: mp3Data.length,
                itemBuilder: (BuildContext ctx, index) {
                  final data = mp3Data[index];
                  return AudioCard(
                    data: data,
                  );
                },
              );
            });
  }
}
