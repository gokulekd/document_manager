import 'dart:developer';

import 'package:document_manager/add%20document/widgets/drop_down_widget.dart';
import 'package:document_manager/home%20page/functions/hive_data_model_functions.dart';
import 'package:document_manager/home%20page/model/data_model.dart';
import 'package:document_manager/home%20page/model/data_model_hive.dart';
import 'package:document_manager/home%20page/view/home_page_new.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AddDocumentPage extends StatefulWidget {
  const AddDocumentPage({super.key});

  @override
  State<AddDocumentPage> createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  String? selectedFilePath;
  String? selectedFileName;
  double? selectedFileSize;

  Object? selectedValue1;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController descriptionController;
  final box = GetStorage();

  DateTime selectedDate = DateTime.now();
  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
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
    nameController = TextEditingController();
    dateController = TextEditingController();
    descriptionController = TextEditingController();
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
    double width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
          shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
          backgroundColor: Colors.white,
          title: Text(
            'Add Document ',
            textScaleFactor: 1.12,
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
            child: Form(
          key: globalKey,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 80),
            children: [
              const Text(
                "Name",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 15),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      return "Please Enter a valid name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Please enter a name (mandatory)",
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
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: "Please select a date (optional)",
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
                  maxLines: 10,
                  controller: descriptionController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    String value = descriptionController.text;
                    if (value.isEmpty) {
                      return "Please Enter a description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Please enter description (mandatory)",
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
              DropDownWidget(
                selectedValue: selectedValue1,
                hintText: "Select document type",
                dropdownItems: dropdownItemsBankBranch,
                validator: (value) =>
                    value == null ? "Please select a document type" : null,
                onChanged: (value) {
                  setState(() {
                    selectedValue1 = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                width: width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 89, 102, 199),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: selectedFileName == null
                            ? const SizedBox(
                                width: 100,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  "Please upload a file ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: width * 0.4,
                                child: Text(
                                  selectedFileName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 57, 61, 134),
                              fixedSize: const Size(120, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () async {
                            // await box.erase();
                            if (selectedValue1 == null) {
                              const snackBar = SnackBar(
                                content: Text('Please select a document type!'),
                              );
                              _scaffoldMessengerKey.currentState
                                  ?.showSnackBar(snackBar);
                            } else {
                              log("the selected value is >>>>> ${selectedValue1.toString()}");
                              pickFile(
                                  selectedValue: selectedValue1.toString());
                            }
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Upload file")),
                    ),
                  ],
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
                        if (globalKey.currentState!.validate()) {
                          if (selectedFilePath != null) {
                            final dataModel = DataModelHive(
                                title: nameController.text,
                                dataID: "no id",
                                description: descriptionController.text,
                                expiryDate: selectedDate,
                                fileSize: selectedFileSize!,
                                filePath: selectedFilePath!,
                                documentType: selectedValue1.toString());
                            addDataToHive(inputData: dataModel);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePageScreen(),
                                ));
                          } else {
                            const snackBar = SnackBar(
                              content: Text(
                                  'Please select a document from your device !'),
                            );
                            _scaffoldMessengerKey.currentState
                                ?.showSnackBar(snackBar);
                          }
                        } else {
                          const snackBar = SnackBar(
                            content: Text('all fields are required !'),
                          );
                          _scaffoldMessengerKey.currentState
                              ?.showSnackBar(snackBar);
                        }
                      },
                      icon: const Icon(Icons.add_rounded),
                      label: const Text("Add file")),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }


  Future<void> pickFile({required String selectedValue}) async {
    FilePickerResult? result;
    if (selectedValue == "mp3") {
      result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        // Specify the allowed file types here
      );
    } else if (selectedValue == "mp4") {
      result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        // Specify the allowed file types here
      );
    } else if (selectedValue == "jpg") {
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // Specify the allowed file types here
      );
    } else {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: [selectedValue]
              );
    }

    if (result != null && selectedValue == result.files.first.extension) {
      log("selected file extension is>>>> ${result.files.first.extension.toString()}");
      PlatformFile file = result.files.first;

      // Handle the picked file
      log('File picked: ${file.name}');
      log('File path: ${file.path}');
      log('File size: ${file.size}');
      setState(() {
        selectedFilePath = file.path;
        selectedFileName = file.name;
        selectedFileSize = double.parse(file.size.toString());
      });
      // ignore: use_build_context_synchronously
    } else {
      log("selected file extension is>>>> ${result!.files.first.extension.toString()}");
// ignore: use_build_context_synchronously
      showAlertDialog(context);
    }
  }

  List<DropdownMenuItem<String>> get dropdownItemsBankBranch {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: "mp3",
        child: Text("Audio"),
      ),
      const DropdownMenuItem(
        value: "mp4",
        child: Text("Video"),
      ),
      const DropdownMenuItem(
        value: "pdf",
        child: Text("pdf"),
      ),
      const DropdownMenuItem(
        value: "jpg",
        child: Text("Image"),
      ),
    ];
    return menuItems;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      onPressed: () async {
        Navigator.pop(context);
      },
      child: const Text("Okay"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text(
          "the selected document type did'nt match with the picked file document type.please try again"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
