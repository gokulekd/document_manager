import 'package:document_manager/details%20view%20page/widgets/document_overview_main_widget.dart';
import 'package:document_manager/edit%20page/widgets/document_details_show_widget_edit_screen.dart';
import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:document_manager/home%20page/view/home_page_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EditDocumentPage extends StatefulWidget {
  int index;
  DataModelHive dataModel;
  EditDocumentPage({super.key, required this.dataModel, required this.index});

  @override
  State<EditDocumentPage> createState() => _EditDocumentPageState();
}

class _EditDocumentPageState extends State<EditDocumentPage> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController descriptionController;

  DateTime? selectedDate;
  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        final dateFormat = DateFormat.yMMMd();
        dateController.text = dateFormat.format(date);
        selectedDate = date;
      });
    }
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.dataModel.title,);
    dateController = TextEditingController(
      text: DateFormat.yMMMd().format(widget.dataModel.expiryDate!),
    );
    descriptionController =
        TextEditingController(text: widget.dataModel.description);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
        backgroundColor: Colors.white,
        title: Text(
          '   Your App\'s Name',
          textScaleFactor: 1.12,
          style: TextStyle(
            color: Colors.black.withOpacity(.7),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10),
              child: DocumentOverViewMainWidget(
                  heightMediaQuery: height,
                  widthMediaQuery: width,
                  documentType: widget.dataModel.documentType,
                  title: widget.dataModel.title),
            ),
            DocumentDetailsShowWidgetEditScreen(width: width),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 15, right: 15, bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        globalKey.currentState!.validate();
                      },
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^[A-Za-z0-9 ]*$')),
                        LengthLimitingTextInputFormatter(60),
                      ],
                      validator: (value) {
                        String value = nameController.text;
                        if (value.isEmpty) {
                          return "Please Enter a valid date";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Expiry date",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        globalKey.currentState!.validate();
                      },
                      validator: (value) {
                        String value = dateController.text;
                        if (value.isEmpty) {
                          return "Please select a valid date";
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: dateController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () => selectDate(),
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            )),
                        border: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                    child: TextFormField(
                      maxLines: 17,
                      onChanged: (value) {
                        globalKey.currentState!.validate();
                      },
                      controller: descriptionController,
                      textInputAction: TextInputAction.next,
                      // inputFormatters: <TextInputFormatter>[
                      //   FilteringTextInputFormatter.allow(
                      //       RegExp(r'^[A-Z a-z]*$')
                      //       ),
                      //   //LengthLimitingTextInputFormatter(20),
                      // ],
                      validator: (value) {
                        String value = nameController.text;
                        if (value.isEmpty) {
                          return "Please Enter a description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 48, 54, 174),
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () async {
                            final data = DataModelHive(
                              title: nameController.text,
                              description: descriptionController.text,
                              expiryDate: selectedDate!,
                              fileSize: widget.dataModel.fileSize,
                              documentType: widget.dataModel.documentType,
                            );
                            await updateData(
                                inputData: data, key: widget.index);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePageScreen(),
                                ));
                          },
                          icon: const Icon(Icons.update),
                          label: const Text("Update file")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
