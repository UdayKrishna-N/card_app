import 'package:card_app/enums/card_type_enum.dart';
import 'package:card_app/enums/card_scheme_enum.dart';
import 'package:hive/hive.dart';

part 'cards_data.g.dart';

@HiveType(typeId: 1)
class CardData extends HiveObject {
  @HiveField(0)
  String cardId;

  @HiveField(1)
  String bankName;

  @HiveField(2)
  String fullName;

  @HiveField(3)
  String cardNumber;

  @HiveField(4)
  String cvv;

  @HiveField(5)
  String validThru;

  @HiveField(6)
  String cardType;

  @HiveField(7)
  String cardScheme;

  @HiveField(8)
  int cardColor;

  CardData({
    required this.cardId,
    required this.bankName,
    required this.fullName,
    required this.cardNumber,
    required this.cvv,
    required this.validThru,
    required this.cardType,
    required this.cardScheme,
    required this.cardColor,
  });
}
