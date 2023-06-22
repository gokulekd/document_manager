

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DocumentOverViewMainWidget extends StatelessWidget {
  String title;

  String documentType;

  double heightMediaQuery;
  double widthMediaQuery;

  DocumentOverViewMainWidget({
    required this.heightMediaQuery,
    required this.widthMediaQuery,
    required this.documentType,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff5C71F3),
                          // image: DecorationImage(
                          //   image: AssetImage("assets/document.png"),
                          //   fit: BoxFit.cover,
                          // ),
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
                            width: widthMediaQuery * 0.48,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              documentType,
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
    );
  }
}
