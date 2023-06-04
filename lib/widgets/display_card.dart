import 'package:card_app/enums/card_scheme_enum.dart';
import 'package:card_app/utils.dart';
import 'package:flutter/material.dart';

import '../enums/card_type_enum.dart';

class DisplayCard extends StatefulWidget {
  DisplayCard({
    Key? key,
    required this.bankName,
    required this.cardScheme,
    required this.cardNumber,
    required this.fullName,
    required this.cardType,
    required this.cardColor,
  }) : super(key: key);

  final String bankName, fullName, cardNumber;
  final CardScheme cardScheme;
  final CardType cardType;
  final Color cardColor;

  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  String cardNumberFormatter(String cardNumber) {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < cardNumber.length; i++) {
      if (i <= 6) {
        buffer.write(cardNumber[i]);
      } else if (cardNumber[i] == ' ') {
        buffer.write(' ');
      } else {
        buffer.write('x');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 230,
        width: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.cardColor,
        ),
        child: Stack(
          children: [
            AppUtils().getCardSchemeImage(CardScheme.mastercard),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          widget.bankName.toUpperCase(),
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        widget.cardType.name.toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    cardNumberFormatter(widget.cardNumber).toUpperCase(),
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      widget.fullName.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        // letterSpacing: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
