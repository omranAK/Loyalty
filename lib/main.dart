import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/app_router.dart';

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
    MyApp(appRouter: AppRouter()),
//  )
  );
  // CacheManager.setLang("en");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        // locale: Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        //   localizationsDelegates: context.localizationDelegates,
        //   supportedLocales: context.supportedLocales,
        //   locale: context.locale,
        title: 'LoyaltySystem',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,

        //   ),
      );
}
