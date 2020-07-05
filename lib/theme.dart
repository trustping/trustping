import 'package:flutter/material.dart';

/// This defines the entire style for the Trustping app
class Style {
  // COLORS
  static const Color textColor = Color.fromRGBO(48, 61, 68, 1.0);
  static const Color textLightColor = Color.fromRGBO(143, 143, 143, 1.0);
  static const Color textDarkColor = Color.fromRGBO(19, 24, 27, 1.0);
  static const Color lightGray = Color.fromRGBO(239, 240, 240, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  // blue-ish
  static const Color blue = Color.fromRGBO(76, 108, 184, 1.0);
  static const Color blue70 = Color.fromRGBO(76, 108, 184, 0.7);
  static const Color blue50 = Color.fromRGBO(76, 108, 184, 0.5);
  static const Color blue30 = Color.fromRGBO(76, 108, 184, 0.3);
  // yellow
  // static const Color yellow = Color.fromRGBO(252, 199, 3, 1.0);
  static const Color yellow = Color.fromRGBO(255, 217, 76, 1.0);
  static const Color yellow70 = Color.fromRGBO(255, 217, 76, 0.7);
  static const Color yellow50 = Color.fromRGBO(255, 217, 76, 0.5);
  static const Color yellow30 = Color.fromRGBO(255, 217, 76, 0.3);
  // red-ish
  static const Color red = Color.fromRGBO(255, 95, 100, 1.0);
  static const Color red70 = Color.fromRGBO(255, 95, 100, 0.7);
  static const Color red50 = Color.fromRGBO(255, 95, 100, 0.5);
  static const Color red30 = Color.fromRGBO(255, 95, 100, 0.3);

  // very simple color swatches
  static const List<Color> blues = [blue, blue70, blue50, blue30];
  static const List<Color> yellows = [yellow, yellow70, yellow50, yellow30];
  static const List<Color> reds = [red, red70, red50, red30];

  static TextStyle titleTS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: textColor,
  );
  static TextStyle subtitleTS = TextStyle(
    // TODO set size properly
    fontFamily: 'Inter',
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: textColor,
  );
  static TextStyle bodyTS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: textColor,
  );
  static TextStyle tinyTS = TextStyle(
    fontFamily: 'Inter',
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
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
    // primaryColor: Colors.white,
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
  static Text tiny(String text) => Text(text, style: tinyTS);
}
