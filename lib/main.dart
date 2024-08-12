import './constant/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager().init();

  runApp(
    MyApp(appRouter: AppRouter()),
  );
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
              ),
              BlocProvider(
                create: (context) => ProfileBloc(
                  ProfileRepository(
                    externalService: ExternalService(),
                  ),
                ),
              ),
            ],
            child: Consumer<GlobalProvider>(
              builder: (context, value, _) => MaterialApp(
                theme:
                    CacheManager.getTHeme() == 'light' ? lightTheme : darkTheme,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: value.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                title: 'LoyaltySystem',
                debugShowCheckedModeBanner: false,
                initialRoute: CacheManager.getUserModel()==null?authscreen:splash,

                // initialRoute: CacheManager.getUserModel() == null
                //     ? authscreen
                //     : CacheManager.getToken() != null &&
                //                 CacheManager.getUserModel()!.active == 1 &&
                //                 CacheManager.getUserModel()!.roleID == 4 ||
                //             CacheManager.getUserModel()!.roleID == 5
                //         ? tabScreen
                //         : authscreen,
                onGenerateRoute: appRouter.generateRoute,

                //   ),
              ),
            ),
          );
        },
      );
}
