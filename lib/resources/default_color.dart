import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add full opacity if not provided
    }
    return int.parse(hexColor, radix: 16);
  }
}

Color primeColor = HexColor("#F1A743");
// Color primeColor = Color.fromARGB(255, 212, 144, 94);
