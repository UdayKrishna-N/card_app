import 'package:flutter/material.dart';

import '../enums/card_type_enum.dart';
import '../enums/card_scheme_enum.dart';

class CardModel {
  String cardId;
  String bankName;
  String fullName;
  String cardNumber;
  String cvv;
  String validThru;
  CardType cardType;
  CardScheme cardScheme;
  Color cardColor;

  CardModel({
    required this.cardId,
    required this.bankName,
    required this.fullName,
    required this.cardNumber,
    required this.validThru,
    required this.cvv,
    this.cardType = CardType.none,
    this.cardScheme = CardScheme.none,
    required this.cardColor,
  });
}
