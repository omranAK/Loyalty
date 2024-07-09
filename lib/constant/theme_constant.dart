import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';

ThemeData lightTheme = ThemeData(
  cardTheme: const CardTheme(color: AppColors.offersLight),
  brightness: Brightness.light,
  bannerTheme:
      const MaterialBannerThemeData(backgroundColor: AppColors.validateLight),
  cardColor: AppColors.cardsColor,
  appBarTheme: const AppBarTheme(color: Colors.white),
  primaryColorDark: Colors.white,
  primaryIconTheme: const IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
  ),
  primaryColor: Colors.grey[400],
);
ThemeData darkTheme = ThemeData(
  cardTheme: const CardTheme(color: AppColors.offersDark),
  bannerTheme: const MaterialBannerThemeData(
    backgroundColor: AppColors.validateDark,
  ),
  primaryColorDark: AppColors.buttonColor,
  cardColor: AppColors.cardsColorDark,
  primaryIconTheme: const IconThemeData(color: Colors.white),
  colorScheme:
      const ColorScheme.dark(background: AppColors.backgroundColorDark),
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.appBarColor,
  ),
);
