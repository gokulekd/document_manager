import 'package:document_manager/add%20document/view/add_document_page.dart';
import 'package:document_manager/constant/color.dart';
import 'package:document_manager/constant/tab_constants.dart';
import 'package:flutter/material.dart';

PreferredSize homePageAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(120),
    child: AppBar(
      leading: const SizedBox(),
      elevation: 20,
      shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
      backgroundColor: whiteColor,
      title: Text(
        'Document manger',
        style: TextStyle(
          color: fadeBlackColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDocumentPage(),
                    ));
              },
              icon: const Icon(Icons.add),
              label: const Text("Add new file")),
        ),
      ],
      bottom: TabBar(
          indicatorColor: fadeBlackColor,
          unselectedLabelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
          unselectedLabelColor: Colors.black.withOpacity(.4),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.black.withOpacity(.8),
          tabs: homePageTabTitle),
    ),
  );
}
