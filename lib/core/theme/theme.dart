import 'package:flutter/material.dart';
import 'package:my_books_ntt/core/theme/color.dart';

class AppTheme {
  static final darkThemeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
