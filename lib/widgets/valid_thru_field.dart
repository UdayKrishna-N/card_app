// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class ValidThruField extends StatelessWidget {
  ValidThruField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        InputFormater(),
      ],
      style: Constants().defaultStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
      cursorColor: Colors.white,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelStyle:
            Constants().defaultStyle.copyWith(color: Constants.yellow),
        labelStyle: Constants().defaultStyle,
        hintStyle: Constants().defaultStyle,
        enabledBorder: Constants().border,
        focusedBorder: Constants().border,
        errorBorder: Constants().border.copyWith(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.white,
      ),
    );
  }
}

class InputFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String enteredData = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    // get data enter by used in textField
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < enteredData.length; i++) {
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 2 == 0 && enteredData.length != index) {
        buffer.write("/");
      }
    }

    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}
