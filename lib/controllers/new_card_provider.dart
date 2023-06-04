import 'package:card_app/database/app_database.dart';
import 'package:card_app/services/bin_service.dart';
import 'package:card_app/enums/card_scheme_enum.dart';
import 'package:card_app/enums/card_type_enum.dart';
import 'package:card_app/models/card_model.dart';
import 'package:card_app/utils.dart';
import 'package:flutter/material.dart';

class NewCardProvider extends ChangeNotifier {
  // bool isCardSaved = false;
  late CardModel card;

  NewCardProvider() {
    card = CardModel(
      cardId: AppUtils.getRandomString(6),
      bankName: '',
      fullName: '',
      cardNumber: '',
      validThru: '',
      cvv: '',
      cardColor: Color(AppUtils().getRandomCardColor()),
      cardType: CardType.none,
      cardScheme: CardScheme.none,
    );
  }

  makeItNone() {
    card.cardScheme = CardScheme.none;
    card.cardType = CardType.none;
    notifyListeners();
  }

  getBin(String number) async {
    var data = await BinService().getBinData(number);
    updateCardType(data["type"]);
    notifyListeners();
    updateCardScheme(data["scheme"]);
    notifyListeners();
  }

  updateCardNumber(String number) async {
    card.cardNumber = number;
    notifyListeners();
  }

  updateBankName(String bankName) {
    card.bankName = bankName;
    notifyListeners();
  }

  updateName(String name) {
    card.fullName = name;
    notifyListeners();
  }

  updateCVV(String cvv) {
    card.cvv = cvv;
    notifyListeners();
  }

  updateValidThru(String validThru) {
    card.validThru = validThru;
    notifyListeners();
  }



  updateCardScheme(String scheme) {
    switch (scheme) {
      case 'visa':
        card.cardScheme = CardScheme.visa;
        break;
      case 'mastercard':
        card.cardScheme = CardScheme.mastercard;
        break;
      case 'rupay':
        card.cardScheme = CardScheme.rupay;
        break;
      default:
        card.cardScheme = CardScheme.none;
        break;
    }
  }

  updateCardType(String type) {
    switch (type) {
      case 'debit':
        card.cardType = CardType.debit;
        break;
      case 'credit':
        card.cardType = CardType.credit;
        break;
      default:
        card.cardType = CardType.none;
        break;
    }
  }
}
