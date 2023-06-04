import 'package:card_app/database/app_database.dart';
import 'package:flutter/cupertino.dart';

import '../enums/card_type_enum.dart';
import '../models/card_model.dart';

class DashboardProvider extends ChangeNotifier{
  late List<CardModel> debitCards, creditCards;

  DashboardProvider() {
    debitCards = AppDatabase().getDebitCards();
    creditCards = AppDatabase().getCreditCards();
  }

  saveCard(CardModel card) {
    AppDatabase().saveCard(card);
    if(card.cardType == CardType.credit){
      AppDatabase().getCreditCardById(card.cardId);
      creditCards.add(card);
      notifyListeners();
    } else {
      AppDatabase().getDebitCardById(card.cardId);
      debitCards.add(card);
      notifyListeners();
    }
  }

}