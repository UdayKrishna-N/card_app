// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CardNumberField extends StatelessWidget {
  CardNumberField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String labelText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
        CardNumberInputFormatter(),
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

class CardNumberInputFormatter extends TextInputFormatter {
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
