import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentDetailsShowWidgetEditScreen extends StatelessWidget {
  const DocumentDetailsShowWidgetEditScreen({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 100,
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
                  children: const [
                    Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 39,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "30.kb",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.file_present_rounded,
                      color: Colors.white,
                      size: 39,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "pdf",
                        style: TextStyle(color: Colors.white),
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
                        DateFormat.yMMMd().format(DateTime.now()),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
