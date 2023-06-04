// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:card_app/constants.dart';
import 'package:flutter/material.dart';

class ExpandableTile extends StatelessWidget {
  ExpandableTile({
    super.key,
    required this.isExpanded,
    required this.title,
    required this.count,
    this.childWidget  = const SizedBox.shrink(),
  });

  final bool isExpanded;
  final String title;
  final int count;
  Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Card(
        elevation: 5,
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 180),
          width: double.infinity,
          height: isExpanded ? MediaQuery
              .of(context)
              .size
              .height * 0.55 : 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              topSection(),
              if (isExpanded)
                Flexible(
                  child: (count == 0) ? Center(
                    child: Text(
                      "No Data Available",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ) : childWidget,),
            ],
          ),
        ),
      ),
    );
  }

  Widget topSection() {
    return Container(
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.yellow,
                        ),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                isExpanded
                    ? Transform.rotate(
                    angle: pi / 2,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ))
                    : Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
