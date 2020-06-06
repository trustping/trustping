import 'package:flutter/material.dart';

/// This defines the entire style for the Trustping app
class Style {
  // COLORS
  static Color textColor = Color.fromRGBO(48, 61, 68, 1.0);
  static Color textLightColor = Color.fromRGBO(143, 143, 143, 1.0);
  static Color textDarkColor = Color.fromRGBO(19, 24, 27, 1.0);
  // blue-ish
  static Color blue = Color.fromRGBO(76, 108, 184, 1.0);
  static Color blue70 = Color.fromRGBO(76, 108, 184, 0.7);
  static Color blue50 = Color.fromRGBO(76, 108, 184, 0.5);
  static Color blue30 = Color.fromRGBO(76, 108, 184, 0.3);
  // yellow
  static Color yellow = Color.fromRGBO(255, 217, 76, 1.0);
  static Color yellow70 = Color.fromRGBO(255, 217, 76, 0.7);
  static Color yellow50 = Color.fromRGBO(255, 217, 76, 0.5);
  static Color yellow30 = Color.fromRGBO(255, 217, 76, 0.3);
  // red-ish
  static Color red = Color.fromRGBO(255, 115, 147, 1.0);
  static Color red70 = Color.fromRGBO(255, 115, 147, 0.7);
  static Color red50 = Color.fromRGBO(255, 115, 147, 0.5);
  static Color red30 = Color.fromRGBO(255, 115, 147, 0.3);

  static TextStyle titleTS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: textColor,
  );
  static TextStyle subtitleTS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18.5,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: textColor,
  );
  static TextStyle bodyTS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 15.0,
    height: 1.2,
    color: textColor,
  );
  static MaterialColor tpColors = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
  static ThemeData themeData = ThemeData(
    fontFamily: 'Inter',
    primarySwatch: tpColors,
    accentColor: yellow,
    textTheme: TextTheme(
      headline1: titleTS,
      headline6: subtitleTS,
      bodyText2: bodyTS,
    ),
  );

  static Text title(String text) => Text(text, style: titleTS);
  static Text subtitle(String text) => Text(text, style: subtitleTS);
  static Text body(String text) => Text(text, style: bodyTS);
}
