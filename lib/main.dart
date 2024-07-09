import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/app_router.dart';
import 'package:loyalty_system_mobile/constant/constant_data.dart';
import 'package:loyalty_system_mobile/constant/firebase.dart';
import 'package:loyalty_system_mobile/constant/theme_constant.dart';
import 'package:loyalty_system_mobile/data/repository/ad_repo.dart';
import 'package:loyalty_system_mobile/data/repository/auth_repo.dart';
import 'package:loyalty_system_mobile/data/repository/charity_repo.dart';
import 'package:loyalty_system_mobile/data/repository/history_repo.dart';
import 'package:loyalty_system_mobile/data/repository/home_repo.dart';
import 'package:loyalty_system_mobile/data/repository/store_repo.dart';
import 'package:loyalty_system_mobile/data/repository/transfer_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/firebase_options.dart';
import 'package:loyalty_system_mobile/logic/ad/bloc/ad_bloc.dart';
import 'package:loyalty_system_mobile/logic/auth/bloc/auth_bloc.dart';
import 'package:loyalty_system_mobile/logic/charity/bloc/charity_bloc.dart';
import 'package:loyalty_system_mobile/logic/history/bloc/history_bloc.dart';
import 'package:loyalty_system_mobile/logic/home/bloc/home_bloc.dart';
import 'package:loyalty_system_mobile/logic/stores/bloc/stores_bloc.dart';
import 'package:loyalty_system_mobile/logic/transfer/bloc/transfer_bloc.dart';
import 'package:loyalty_system_mobile/presentation/screens/splash_screen.dart';
import 'package:loyalty_system_mobile/provider/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  await CacheManager().init();
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
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GlobalProvider(),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(
                  AuthRepository(
                    externalService: ExternalService(),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => HomeBloc(
                  HomeRepository(
                    ExternalService(),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => TransferBloc(
                  TransferRepository(
                    ExternalService(),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => StoresBloc(
                  StoreRepository(
                    externalService: ExternalService(),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => CharityBloc(
                  CharityRepository(
                    externalService: ExternalService(),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => HistoryBloc(
                  HistortyRepository(
                    externalService: ExternalService(),
                  ),
                ),
              ),
              BlocProvider(
                create: (context) => AdBloc(
                  AdRepository(
                    externalService: ExternalService(),
                  ),
                ),
              )
            ],
            child: Consumer<GlobalProvider>(
              builder: (context, value, _) => MaterialApp(
                theme:
                    CacheManager.getTHeme() == 'light' ? lightTheme : darkTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: Locale(CacheManager.getLang() != null
                    ? CacheManager.getLang()!
                    : 'en'),
                supportedLocales: AppLocalizations.supportedLocales,
                title: 'LoyaltySystem',
                debugShowCheckedModeBanner: false,
                //home:const  SplashScreen(),
                initialRoute: CacheManager.getUserModel() == null
                    ? authscreen
                    : CacheManager.getToken() != null &&
                                CacheManager.getUserModel()!.active == 1 &&
                                CacheManager.getUserModel()!.roleID == 4 ||
                            CacheManager.getUserModel()!.roleID == 5
                        ? tabScreen
                        : authscreen,
                onGenerateRoute: appRouter.generateRoute,

                //   ),
              ),
            ),
          );
        },
      );
}
