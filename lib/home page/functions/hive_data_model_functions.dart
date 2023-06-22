import 'dart:developer';

import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:hive/hive.dart';

import 'package:flutter/material.dart';

ValueNotifier<List<DataModelHive>> mp3DataNotifier = ValueNotifier([]);
ValueNotifier<List<DataModelHive>> pdfDataNotifier = ValueNotifier([]);
ValueNotifier<List<DataModelHive>> videoDataNotifier = ValueNotifier([]);
ValueNotifier<List<DataModelHive>> imageDataNotifier = ValueNotifier([]);
int mp3DataNotifierLength = 0;

void addDataToHive({required DataModelHive inputData}) async {
  if (inputData.documentType == "mp3") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("audioData");
    hiveModelObject.add(inputData);
  }
  if (inputData.documentType == "mp4") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("videoData");
    hiveModelObject.add(inputData);
  }
  if (inputData.documentType == "pdf") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("documentData");
    await hiveModelObject.add(inputData);
  }
  if (inputData.documentType == "jpg") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("imageData");
    await hiveModelObject.add(inputData);
  }
  log("added data success with ${inputData.documentType} extension");
}

getMp3DataFromHive() async {
  final hiveModelObject = await Hive.openBox<DataModelHive>("audioData");
  mp3DataNotifier.value.clear();
  mp3DataNotifier.value.addAll(hiveModelObject.values);
  mp3DataNotifierLength = mp3DataNotifier.value.length;
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  mp3DataNotifier.notifyListeners();
}

getPdfDataFromHive() async {
  final hiveModelObject = await Hive.openBox<DataModelHive>("documentData");
  pdfDataNotifier.value.clear();
  pdfDataNotifier.value.addAll(hiveModelObject.values);
  log("total data is added only ${pdfDataNotifier.value.length.toString()}");
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  pdfDataNotifier.notifyListeners();
}

getImageDataFromHive() async {
  final hiveModelObject = await Hive.openBox<DataModelHive>("imageData");
  imageDataNotifier.value.clear();
  imageDataNotifier.value.addAll(hiveModelObject.values);

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  imageDataNotifier.notifyListeners();
}

getVideoDataFromHive() async {
  final hiveModelObject = await Hive.openBox<DataModelHive>("videoData");
  videoDataNotifier.value.clear();
  videoDataNotifier.value.addAll(hiveModelObject.values);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  videoDataNotifier.notifyListeners();
}

updateData({required DataModelHive inputData,required int key}) async {
  if (inputData.documentType == "mp3") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("audioData");
    await hiveModelObject.put(key, inputData);
  }
  if (inputData.documentType == "mp4") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("videoData");
    await hiveModelObject.put(key, inputData);
  }
  if (inputData.documentType == "Pdf") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("documentData");
    await hiveModelObject.put(key, inputData);
  }
  if (inputData.documentType == "jpg") {
    final hiveModelObject = await Hive.openBox<DataModelHive>("imageData");
    await hiveModelObject.put(key, inputData);
  }
  log("added data success with ${inputData.documentType} extension");
}
