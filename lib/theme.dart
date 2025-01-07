import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF7E49FF),
    elevation: 4,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF7E49FF),
    primaryContainer: Color.fromARGB(255, 191, 194, 194),
    onPrimaryContainer: Color(0xFF64748B),
    secondary: Color(0xFF7E49FF),
    tertiary: Color(0xFFD9D9D9),
    surface: Color.fromARGB(255, 255, 255, 255),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
