import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle defaultBold({Color color = Colors.white}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle mediumBold({Color color = Colors.white}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle largeBold({Color color = Colors.white}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      color: color,
    );
  }
}
