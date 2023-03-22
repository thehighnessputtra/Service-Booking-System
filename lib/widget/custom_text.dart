// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextSmall extends StatelessWidget {
  CustomTextSmall({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      "*$text",
      style: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 12,
      ),
    );
  }
}
