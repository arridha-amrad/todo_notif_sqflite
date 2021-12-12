import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 0))),
    primarySwatch: Colors.indigo,
    textTheme: const TextTheme(button: TextStyle(color: Colors.white)),
    primaryColor: Colors.indigo,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    brightness: Brightness.dark,
    textTheme: const TextTheme(button: TextStyle(color: Colors.black)),
    primarySwatch: Colors.amber,
    primaryColor: Colors.amber,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  ));
}

TextStyle get textFieldLabelStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ));
}
