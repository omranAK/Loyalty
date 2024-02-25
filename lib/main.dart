import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import 'data/provider/global_provider.dart';
import 'data/storage/cache_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheManager().init();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('ar', 'SA'),
      Locale('en', 'US'),
    ],
    path: 'assets/languages',
    fallbackLocale: const Locale('en', 'US'),
    startLocale: const Locale('en', 'US'),
    child: const MyApp(),
  ));
  CacheManager.setLang("en");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GlobalProvider(),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'InternetApplicationsProject',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                //primarySwatch: Colors.blue,
                fontFamily: context.locale == const Locale('en', 'US')
                    ? 'Montserrat-M'
                    : 'Frutiger-R',
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
              ),

              //  home: const LoginScreen(),
            ),
          );
        },
      );
}
