import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors defined in the image
  static const Color primaryColor = Color(0xFF000000);
  static const Color secondaryColor = Color(0xFF121212);
  static const Color tertiaryColor = Color(0xFF000000);
  static const Color neutralColor = Color(0xFFE0E0E0);
  
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: secondaryColor,
      colorScheme: const ColorScheme.dark(
        primary: neutralColor,
        onPrimary: primaryColor,
        secondary: secondaryColor,
        onSecondary: neutralColor,
        tertiary: tertiaryColor,
        surface: secondaryColor,
        onSurface: neutralColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        titleTextStyle: GoogleFonts.beVietnamPro(
          color: neutralColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: neutralColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neutralColor, // Primary button
          foregroundColor: primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: neutralColor,
          side: BorderSide(color: Colors.grey.shade700),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: neutralColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: neutralColor),
        ),
        labelStyle: GoogleFonts.beVietnamPro(color: Colors.grey.shade400),
        hintStyle: GoogleFonts.beVietnamPro(color: Colors.grey.shade500),
      ),
      iconTheme: const IconThemeData(
        color: neutralColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
        selectedItemColor: neutralColor,
        unselectedItemColor: Colors.grey.shade600,
      ),
    );
  }
}
