import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:loyalty_system_mobile/presentation/screens/home_screen.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
//  await EasyLocalization.ensureInitialized();
  //await CacheManager().init();
  runApp(
    //   EasyLocalization(
    // supportedLocales: const [
    //   Locale('ar', 'SA'),
    //   Locale('en', 'US'),
    // ],
    // path: 'assets/languages',
    // fallbackLocale: const Locale('en', 'US'),
    // startLocale: const Locale('en', 'US'),
    // child:
    const MyApp(),
//  )
  );
  // CacheManager.setLang("en");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) =>
      //  MultiBlocProvider(
  // providers: [],
  // child:
  MaterialApp(
    //   localizationsDelegates: context.localizationDelegates,
    //   supportedLocales: context.supportedLocales,
    //   locale: context.locale,
    title: 'LoyaltySystem',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      //   fontFamily: context.locale == const Locale('en', 'US')
      // ? 'Montserrat-M'
      //   : 'Frutiger-R',
      colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    ),

    home: const HomeScreen(),
    //   ),
  );
}
