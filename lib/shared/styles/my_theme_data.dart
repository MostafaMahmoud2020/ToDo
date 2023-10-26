import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: whiteColor,
          onPrimary: blackColor,
          secondary: primaryColor,
          onSecondary: primaryColor,
          error: Colors.red,
          onError: Colors.red,
          background: whiteColor,
          onBackground: blackColor,
          surface: primaryColor,
          onSurface: primaryColor),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: primaryColor, size: 30),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        bodySmall: GoogleFonts.poppins(
            fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black),
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: blackColor,
          onPrimary: whiteColor,
          secondary: primaryColor,
          onSecondary: primaryColor,
          error: Colors.red,
          onError: Colors.red,
          background: blackColor,
          onBackground: whiteColor,
          surface: primaryColor,
          onSurface: primaryColor),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: primaryColor, size: 30),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        bodySmall: GoogleFonts.poppins(
            fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black),
      ));
}
