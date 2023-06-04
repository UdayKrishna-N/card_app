import 'package:flutter/material.dart';

class Constants {
  static Color yellow = Color(0xFFF2FE8D);

  InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.white,
        width: 1.5,
      ));

  TextStyle defaultStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white70,
  );
}
