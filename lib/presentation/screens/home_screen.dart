// ignore_for_file: prefer_typing_uninitialized_variables

import '../../constant/imports.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Bloc homeBloc;
  var point;
  List<VoucherModel> vouchers = [];
  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetHomeDateEvent());
    super.initState();
  }

  Future<void> reGet() async {
    homeBloc.add(GetHomeDateEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final items = [
      PopupMenuItem(
        onTap: () {
          Provider.of<GlobalProvider>(context, listen: false).updateLanguage();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.language,
              color: theme.primaryIconTheme.color,
            ),
            Text(localizations!.english),
          ],
        ),
      ),
      PopupMenuItem(
        onTap: () {
          Provider.of<GlobalProvider>(context, listen: false).updateTheme();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.nights_stay_outlined,
              color: theme.primaryIconTheme.color,
            ),
            Text(localizations.light)
          ],
        ),
      ),
      PopupMenuItem(
        onTap: () => Navigator.pushNamed(context, about),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.help_outline_rounded,
              color: theme.primaryIconTheme.color,
            ),
            Text(localizations.help)
          ],
        ),
      ),
      PopupMenuItem(
        child: GestureDetector(
          onTap: () {
            homeBloc.add(LogoutButtonPressedEvent());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.logout,
                color: theme.primaryIconTheme.color,
              ),
              Text(localizations.logout),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          localizations.home,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: SingleChildScrollView(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is LogoutSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, authscreen, (route) => false);
            } else if (state is DataLoadedState) {
              vouchers = state.vouchers;
              point = state.points;
              CacheManager.setPoint(point.toString());
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                color: Colors.black,
                                spreadRadius: -6,
                              )
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                profile,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).toggleButtonsTheme.color,
                              radius: 30,
                              child: const Icon(
                                Icons.person_outline_rounded,
                                color: AppColors.green,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: SizedBox(
                            width: width * 0.31,
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                return Text(
                                  CacheManager.getUserModel()!
                                      .name
                                      .toUpperCase(),
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, notification);
                          },
                          icon: Icon(
                            Icons.notifications,
                            color: theme.primaryIconTheme.color,
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.settings,
                            color: theme.primaryIconTheme.color,
                            size: 22,
                          ),
                          itemBuilder: (_) => items,
                        ),
                      ],
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.lightGreen,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, barcode);
                            },
                            icon: const Icon(
                              Icons.qr_code_scanner_outlined,
                              size: 35,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          BlocListener<HomeBloc, HomeState>(
                            listener: (context, state) {
                              if (state is GenerateOtpSuccessState) {
                                QuickAlert.show(
                                    backgroundColor: theme.cardColor,
                                    context: context,
                                    type: QuickAlertType.success,
                                    title: state.otp,
                                    titleColor:
                                        theme.textTheme.titleMedium!.color!,
                                    text: localizations.givethisotptothecashier,
                                    textColor:
                                        theme.textTheme.titleMedium!.color!,
                                    confirmBtnColor: AppColors.buttonColor,
                                    confirmBtnText: localizations.done);
                              } else if (state is GenerateOtpFailedState) {
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: localizations.failed,
                                    text: state.errorMessage,
                                    confirmBtnColor: AppColors.buttonColor,
                                    confirmBtnText: localizations.done);
                              }
                            },
                            child: TextButton(
                              onPressed: () {
                                homeBloc.add(GenerateOtpEvent());
                              },
                              child: const Text(
                                "OTP",
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 35, top: 35),
                          width: width * 0.36,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.pointCardColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<HomeBloc, HomeState>(
                                buildWhen: (previous, current) =>
                                    current is DataLoadingState ||
                                    current is DataLoadedState ||
                                    current is DataFaildState,
                                builder: (context, state) {
                                  if (state is DataLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Text(
                                      ("$point"),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  }
                                },
                              ),
                              Text(
                                localizations.point,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (CacheManager.getUserModel()!.roleID == 4)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, videoplayer);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(width * 0.1, height * 0.06),
                        backgroundColor: const Color.fromRGBO(46, 56, 56, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        localizations.watchadd,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                const Divider(
                  endIndent: 50,
                  indent: 50,
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  children: [
                    Text(
                      localizations.myvouchers,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.46,
                  child: RefreshIndicator(
                    onRefresh: () {
                      return reGet();
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) =>
                          current is DataLoadingState ||
                          current is DataLoadedState ||
                          current is DataFaildState,
                      builder: (context, state) {
                        if (state is DataLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color:
                                  Theme.of(context).badgeTheme.backgroundColor,
                            ),
                          );
                        } else if (state is DataFaildState) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localizations.somthingwentwrong,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.restart_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    homeBloc.add(
                                      GetHomeDateEvent(),
                                    );
                                  },
                                  label: Text(
                                    localizations.regetdata,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return vouchers.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (ctx, i) => VoucherItem(
                                    voucher: vouchers[i],
                                  ),
                                  itemCount: vouchers.length,
                                )
                              : Center(
                                  child: Text(
                                    localizations.youhavenovoucher,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
