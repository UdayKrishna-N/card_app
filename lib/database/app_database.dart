import 'dart:io';

import 'package:card_app/database/cards_data.dart';
import 'package:card_app/enums/card_type_enum.dart';
import 'package:card_app/main.dart';
import 'package:card_app/models/card_model.dart';
import 'package:card_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  static const String debitCardBox = 'debitCardBox';
  static String creditCardBox = 'creditCardBox';

  Future<void> initialize() async {
    if (Platform.isAndroid) {
      PackageInfo package = await PackageInfo.fromPlatform();
      var path =
          '/storage/emulated/0/Android/media/${package.packageName}/Data';
      Directory dir = Directory(path);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      await Hive.initFlutter(path);
    } else {
      var dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);
    }
    Hive.registerAdapter(CardDataAdapter());
  }

  saveCard(CardModel card) {
    CardData cardData = CardData(
      cardId: card.cardId,
      bankName: card.bankName,
      fullName: card.fullName,
      cardNumber: card.cardNumber,
      cvv: card.cvv,
      validThru: card.validThru,
      cardType: card.cardType.name,
      cardScheme: card.cardScheme.name,
      cardColor: card.cardColor.value,
    );
    if (card.cardType == CardType.debit) {
      addDebitCard(cardData);
    } else if (card.cardType == CardType.credit) {
      addCreditCard(cardData);
    }
  }

  List<CardModel> getCreditCards() {
    var creditCards = creditBox.values.toList();
    var cards = creditCards
        .map(
          (card) => CardModel(
            cardId: card.cardId,
            bankName: card.bankName,
            fullName: card.fullName,
            cardNumber: card.cardNumber,
            validThru: card.validThru,
            cvv: card.cvv,
            cardScheme: AppUtils().getCardScheme(card.cardScheme),
            cardType: AppUtils().getCardType(card.cardType),
            cardColor: Color(card.cardColor),
          ),
        )
        .toList();
    return cards;
  }

  addCreditCard(CardData card) {
    creditBox.put(card.cardId, card);
  }

  getCreditCardById(String id) {
    return creditBox.get(id);
  }

  List<CardModel> getDebitCards() {
    var debitCards = debitBox.values.toList();
    var cards = debitCards
        .map(
          (card) => CardModel(
            cardId: card.cardId,
            bankName: card.bankName,
            fullName: card.fullName,
            cardNumber: card.cardNumber,
            validThru: card.validThru,
            cvv: card.cvv,
            cardScheme: AppUtils().getCardScheme(card.cardScheme),
            cardType: AppUtils().getCardType(card.cardType),
            cardColor: Color(card.cardColor),
          ),
        )
        .toList();
    return cards;
  }

  addDebitCard(CardData card) {
    debitBox.put(card.cardId, card);
  }

  getDebitCardById(String id) {
    return debitBox.get(id);
  }
}
