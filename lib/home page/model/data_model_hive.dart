// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'data_model_hive.g.dart';

@HiveType(typeId: 1)
class DataModelHive {
  @HiveField(0)
  String? dataID;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime? expiryDate;

  @HiveField(4)
  double fileSize;

  @HiveField(5)
  String? filePath;

  @HiveField(6)
  String documentType;
  DataModelHive({
    this.dataID,
    required this.title,
    required this.description,
    this.expiryDate,
    required this.fileSize,
    this.filePath,
    required this.documentType,
  });
}
