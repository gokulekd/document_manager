import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DocumentDetailsShowWidget extends StatelessWidget {
  DocumentDetailsShowWidget(
      {super.key,
      required this.width,
      required this.data,
      required this.fileSize});

  final double width;
  DataModelHive data;
  String fileSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: 190,
        width: width,
        color: const Color.fromARGB(255, 89, 102, 199),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 39,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${fileSize}Mb",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Icon(
                      Icons.file_present_rounded,
                      color: Colors.white,
                      size: 39,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.documentType,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.date_range,
                      color: Colors.white,
                      size: 39,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMd().format(data.expiryDate!),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 48, 54, 174),
                    fixedSize: const Size(90, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const EditDocumentPage(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit")),
          ],
        ),
      ),
    );
  }
}
