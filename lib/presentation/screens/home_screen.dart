import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/constant_data.dart';
import 'package:loyalty_system_mobile/data/models/voucher_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/logic/home/bloc/home_bloc.dart';
import 'package:loyalty_system_mobile/presentation/widgets/voucher_item.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Bloc homeBloc;
  var point;
  bool isLoading = true;
  bool voucherLoading = true;
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
    final items = [
      const PopupMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.language), Text('English')],
        ),
      ),
      const PopupMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.nights_stay_outlined), Text('Light')],
        ),
      ),
      const PopupMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.help_outline_rounded), Text('Help ')],
        ),
      ),
      PopupMenuItem(
        child: GestureDetector(
          onTap: () {
            homeBloc.add(LogoutButtonPressedEvent());
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.logout),
              Text('Logout'),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
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
      body: BlocListener<HomeBloc, HomeState>(
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
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 15,
                                    color: Colors.black,
                                    spreadRadius: -6)
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, profile,
                                    arguments: point);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  color: AppColors.green,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                CacheManager.getUserModel().name.toUpperCase(),
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          PopupMenuButton(
                              icon: const Icon(
                                Icons.settings,
                                color: AppColors.textColor,
                                size: 22,
                              ),
                              itemBuilder: (_) => items),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightGreen,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.qr_code_scanner_outlined,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "OTP",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                fontSize: 20),
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
                        width: 150,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.pointCardColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is DataLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Text(
                                  ("$point"),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                            const Text(
                              'points',
                              style: TextStyle(
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: const Color.fromRGBO(46, 56, 56, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Get new Voucher',
                    style: GoogleFonts.montserrat(
                      textStyle:
                          const TextStyle(fontSize: 18, color: Colors.white),
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
                    "My Vouchers:",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 243,
                child: RefreshIndicator(
                  onRefresh: () {
                    return reGet();
                  },
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is DataLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DataFaildState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Somthing Went Wrong!!!! Try again Please',
                                style: GoogleFonts.montserrat(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              ElevatedButton.icon(
                                  icon: const Icon(Icons.dangerous),
                                  onPressed: () {
                                    homeBloc.add(
                                      GetHomeDateEvent(),
                                    );
                                  },
                                  label: const Text('data'))
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
                                  'You Have No Voucher Yet!!!!!',
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
    );
  }
}
