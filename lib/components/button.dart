import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  // final IconData icon;
  final Color color;
  var onPressed;

  RoundedButton(
      {required this.text,
      // required this.icon,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(text), // <-- Text
      backgroundColor: color,
      // icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
