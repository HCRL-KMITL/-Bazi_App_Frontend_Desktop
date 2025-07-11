import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color fcolor = const Color(0xFF2D4262);
const Color wColor = Color(0xFFF5E6E8);

final ThemeData appTheme = ThemeData(
    primaryColor: const Color(0xFF862D2D),
    disabledColor: const Color(0xFFD9D9D9),
    scaffoldBackgroundColor: const Color(0xFFF5E6E8),
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
      headlineLarge: GoogleFonts.kanit(
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      headlineMedium: GoogleFonts.kanit(
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      headlineSmall: GoogleFonts.kanit(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bodyLarge: GoogleFonts.kanit(
        textStyle: const TextStyle(
          fontSize: 18,
        ),
      ),
      bodyMedium: GoogleFonts.kanit(
        textStyle: const TextStyle(
          fontSize: 16,
        ),
      ),
      bodySmall: GoogleFonts.kanit(
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    ));
