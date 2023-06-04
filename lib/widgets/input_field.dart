// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class InputField extends StatelessWidget {
  InputField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.textLength = 30,
    this.digitsOnly = false,
    this.isCardNumberField = false,
    this.isValidThruField = false,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  TextInputType keyboardType;
  int textLength;
  bool digitsOnly, isCardNumberField, isValidThruField;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textAlign: textAlign,
      onChanged: onChanged,
      inputFormatters: [
        LengthLimitingTextInputFormatter(textLength),
        if (isCardNumberField) CardNumberInputFormater(),
        if (isCardNumberField) FilteringTextInputFormatter.digitsOnly,
        // isValidThruField ? : null,
      ],
      style: Constants().defaultStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
      cursorColor: Colors.white,
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

class CardNumberInputFormater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enteredData = newValue.text; // get data enter by used in textField
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < enteredData.length; i++) {
      // add each character into String buffer
      buffer.write(enteredData[i]);
      int index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        // add space after 4th digit
        buffer.write(" ");
      }
    }

    return TextEditingValue(
        text: buffer.toString(), // final generated credit card number
        selection: TextSelection.collapsed(
            offset: buffer.toString().length) // keep the cursor at end
        );
  }
}
