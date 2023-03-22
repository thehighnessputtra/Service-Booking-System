// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  CustomButton1({required this.btnName, required this.onPress, super.key});
  VoidCallback onPress;
  String btnName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0, backgroundColor: Colors.lightGreen),
        onPressed: onPress,
        child: Text(
          btnName,
        ));
  }
}

class CustomButton2 extends StatelessWidget {
  CustomButton2({required this.btnName, required this.onPress, super.key});
  VoidCallback onPress;
  String btnName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.red),
        onPressed: onPress,
        child: Text(
          btnName,
        ));
  }
}

class CustomButton3 extends StatelessWidget {
  CustomButton3({required this.btnName, required this.onPress, super.key});
  VoidCallback onPress;
  String btnName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0, backgroundColor: Colors.orange),
        onPressed: onPress,
        child: Text(
          btnName,
        ));
  }
}
