import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
      fontFamily: "Poppins",
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.secondBackground,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        prefixIconColor: const Color(0xFF606062),
        suffixIconColor:const Color(0xFF606062) ,
        hintStyle: const TextStyle(color: Color(0xFF606062)),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      buttonTheme: const ButtonThemeData(highlightColor: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));
}
