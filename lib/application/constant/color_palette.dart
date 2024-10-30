import 'package:flutter/material.dart';

Color hexColor({required String color}) {
  int hex = int.parse('0xFF${color.replaceAll('#', '')}');
  return Color(hex);
}

class ColorPalette {
  static const Color primary = Color(0xFFeb4034);
  static const Color secondary = Color(0xFF961c14);
  static const Color white = Color(0xFFfcfafa);
  static const Color grey = Color(0xFFc7c3c3);
  static const Color black = Color(0xFF0a0101);
  static Color colorAccent = hexColor(color: '#FFC88D');
}
