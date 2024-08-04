import 'package:loyalty_system_mobile/constant/imports.dart';

ThemeData lightTheme = ThemeData(
  shadowColor: Colors.grey.withOpacity(0.5),
    textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.black)),
    toggleButtonsTheme: const ToggleButtonsThemeData(color: Colors.white),
    badgeTheme: const BadgeThemeData(backgroundColor: AppColors.appBarColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightGreen),
    cardTheme: const CardTheme(color: AppColors.offersLight),
    bannerTheme:
        const MaterialBannerThemeData(backgroundColor: AppColors.validateLight),
    primaryColor: AppColors.buttonColor,
    cardColor: AppColors.cardsColor,
    primaryIconTheme: const IconThemeData(color: Colors.black),
    colorScheme: const ColorScheme.light(
        primaryContainer: Colors.white,
        background: AppColors.backgroundColorLight,
        brightness: Brightness.light),
    appBarTheme: const AppBarTheme(color: Colors.white),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.buttonColor),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.buttonColor));

ThemeData darkTheme = ThemeData(
    shadowColor: Colors.black.withOpacity(0.5),
    textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
    toggleButtonsTheme:
        const ToggleButtonsThemeData(color: AppColors.buttonColor),
    badgeTheme: BadgeThemeData(backgroundColor: Colors.grey[400]),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.appBarColor),
    cardTheme: const CardTheme(color: AppColors.offersDark),
    bannerTheme: const MaterialBannerThemeData(
      backgroundColor: AppColors.validateDark,
    ),
    primaryColor: Colors.white,
    cardColor: AppColors.cardsColorDark,
    primaryIconTheme: const IconThemeData(color: Colors.white),
    colorScheme: const ColorScheme.dark(
      background: AppColors.backgroundColorDark,
      brightness: Brightness.dark,
      primaryContainer: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorDark,
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColors.buttonColor),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.buttonColor));
