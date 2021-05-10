import 'package:flutter/material.dart';

class StyleTheme {
  StyleTheme._();

  static const TextStyle headline =
      TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle subtitle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontFamily: 'Handlee',
  );

  static const TextStyle appNameStyle =
      TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle display2 = TextStyle(
    fontSize: 22,
    letterSpacing: 0.2,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle display3 =
      TextStyle(fontFamily: 'Roboto', color: Colors.grey);
  static const TextStyle caption = TextStyle(
      fontSize: 20,
      letterSpacing: 0.2,
      fontFamily: 'Handlee',
      fontWeight: FontWeight.w700,
      color: Colors.white);
}
