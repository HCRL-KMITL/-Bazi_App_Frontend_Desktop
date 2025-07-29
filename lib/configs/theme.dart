import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color fcolor = const Color(0xFF2D4262);
const Color wColor = Color(0xFFF5E6E8);
const Color primaryColor = Color(0xFF862D2D);

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  disabledColor: const Color(0xFFD9D9D9),
  scaffoldBackgroundColor: wColor,
  focusColor: fcolor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: fcolor),
    ),
    floatingLabelStyle: TextStyle(color: fcolor),
  ),
  fontFamily: GoogleFonts.kanit().fontFamily,
  textTheme: TextTheme(
    // 24->14
    headlineLarge: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    headlineMedium: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    ),
    headlineSmall: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    bodyLarge: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 22,
      ),
    ),
    bodyMedium: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 21,
      ),
    ),
    bodySmall: GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 19,
      ),
    ),
  ),
);

extension CustomTextTheme on TextTheme {
  TextStyle get headlineMediumRed => GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    );

  TextStyle get bodyLargeRed => GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: primaryColor,
      ),
    );

    TextStyle get headlineSmallW => GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: wColor,
      ),
    );

    TextStyle get bodyMediumWcolor => GoogleFonts.kanit(
      textStyle: const TextStyle(
        fontSize: 21,
        color: wColor,
      ),
    );
}