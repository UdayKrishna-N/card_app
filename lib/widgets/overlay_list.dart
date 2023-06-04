import 'package:flutter/material.dart';

class OverlayList extends StatefulWidget {
  const OverlayList({super.key});

  @override
  State<OverlayList> createState() => _OverlayListState();
}

class _OverlayListState extends State<OverlayList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
