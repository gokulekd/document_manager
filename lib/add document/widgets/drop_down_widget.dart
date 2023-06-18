// ignore: must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatelessWidget {
  DropDownWidget(
      {Key? key,
      required this.selectedValue,
      required this.hintText,
      required this.dropdownItems,
      required this.validator,
      required this.onChanged})
      : super(key: key);
  Object? selectedValue;
  List<DropdownMenuItem<String>> dropdownItems;
  void Function(Object?)? onChanged;
  String? Function(dynamic)? validator;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: DropdownButtonFormField(
          icon: const Icon(
            Icons.arrow_drop_down,
          //  color: kBlack,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorStyle: const TextStyle(
              fontSize: 16.0,
            ),
            enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              //borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
          //  fillColor: kWhite,
          ),
          validator: validator,
          hint: Text(hintText,
              style: const TextStyle(fontSize: 17, )),
          // dropdownColor: kWhite,
      borderRadius: BorderRadius.circular(15),
        //  style: const TextStyle(color: kBlack),
          value: selectedValue,
          onChanged: onChanged,
          items: dropdownItems),
    );
  }
}
