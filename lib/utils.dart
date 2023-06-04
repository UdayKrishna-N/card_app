import 'dart:math';

import 'package:flutter/material.dart';

import 'enums/card_scheme_enum.dart';
import 'enums/card_type_enum.dart';

class AppUtils {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
  static String getRandomString(int length) {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  List<Color?> colors = [
    Colors.grey[800],
    Colors.deepPurple,
    Colors.pink,
    Colors.red[700],
    Colors.green[900],
    Colors.yellow[700],
    Colors.black87,
  ];

  int getRandomCardColor() {
    return colors[_rnd.nextInt(colors.length)]!.value;
  }

  getCardType(String type){
    switch(type){
      case 'credit':
        return CardType.credit;
      case 'debit':
        return CardType.debit;
      case 'none':
        return CardType.none;
    }
  }

  getCardScheme(String scheme){
    switch(scheme){
      case 'visa':
        return CardScheme.visa;
      case 'mastercard':
        return CardScheme.mastercard;
      case 'rupay':
        return CardScheme.rupay;
      case 'none':
        return CardScheme.none;
    }
  }

  getCardSchemeImage(CardScheme scheme) {
    switch (scheme) {
      case CardScheme.visa:
        return Positioned(
          bottom: 0,
          right: 10,
          child: SizedBox(
            width: 80,
            height: 70,
            child: Image.asset(
              'assets/icons/visa.png',
              width: 70,
              fit: BoxFit.contain,
            ),
          ),
        );
      case CardScheme.mastercard:
        return Positioned(
          bottom: 0,
          right: 10,
          child: SizedBox(
            width: 80,
            height: 70,
            child: Image.asset(
              'assets/icons/mastercard.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      case CardScheme.rupay:
        return Positioned(
          bottom: 0,
          right: 10,
          child: SizedBox(
            width: 80,
            height: 70,
            child: Image.asset(
              'assets/icons/rupay.png',
              // width: 70,
              fit: BoxFit.contain,
            ),
          ),
        );
      case CardScheme.none:
        return SizedBox.shrink();
      default:
        return SizedBox.shrink();
    }
  }
}
