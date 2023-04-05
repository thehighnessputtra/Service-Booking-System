import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final BorderRadiusGeometry? border;
  final VoidCallback onTap;

  const CustomCardWidget(
      {super.key,
      required this.icon,
      required this.color,
      required this.text,
      this.border,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 95,
        padding: EdgeInsets.all(5),
        height: 95,
        decoration: BoxDecoration(color: color, borderRadius: border),
        child: Column(
          children: [
            Spacer(),
            Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
