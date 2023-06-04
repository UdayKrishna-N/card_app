import 'package:card_app/presentation/add_card_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                navigatorButton(
                  iconData: Icons.credit_card_outlined,
                  text: 'Add Card',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCardPage())),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.grey[400],
                ),
                navigatorButton(
                    iconData: Icons.upload_file,
                    text: 'Upload File',
                    onTap: null),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navigatorButton({
    required IconData iconData,
    required String text,
    required void Function()? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        // splashFactory: NoSplash.splashFactory,
        // splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Constants.yellow,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
}
