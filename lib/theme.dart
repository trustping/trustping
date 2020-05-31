import 'package:flutter/material.dart';

/// This defines the entire style for the Trustping app
class Style {
  static Color textColor = Color.fromRGBO(48, 61, 68, 1.0);
  static Color textLightColor = Color.fromRGBO(143, 143, 143, 1.0);
  static Color textDarkColor = Color.fromRGBO(19, 24, 27, 1.0);
  // yellow
  static Color accentColor1 = Color.fromRGBO(255, 217, 76, 1.0);
  // blue-ish
  static Color accentColor2 = Color.fromRGBO(255, 115, 147, 1.0);
  // red-ish
  static Color accentColor3 = Color.fromRGBO(76, 108, 184, 1.0);

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
    accentColor: accentColor1,
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
