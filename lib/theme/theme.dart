import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoipokaTheme {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF00D632);
  static const Color deepForest = Color(0xFF1B4332);
  static const Color earthyBeige = Color(0xFFF9F8F4);
  static const Color juteBrown = Color(0xFF8D6E63);
  static const Color errorRed = Color(0xFFE53935);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: deepForest,
        surface: earthyBeige,
      ),
      scaffoldBackgroundColor: earthyBeige,

      // Global Card Theme (30dp as per your mockups)
        cardTheme: CardThemeData( // Use CardThemeData here
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.white,
        ),

      // Typography for Bangla + English
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: deepForest),
        bodyLarge: GoogleFonts.hindSiliguri(color: deepForest),
        bodyMedium: GoogleFonts.poppins(color: Colors.black87),
      ),

      // Input Decoration (Clean, Rounded)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
      ),

      // Primary Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
