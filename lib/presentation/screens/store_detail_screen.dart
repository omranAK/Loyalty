import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/logic/stores/bloc/stores_bloc.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_offer_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_vouchers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreDetailScreen extends StatefulWidget {
  final int storeID;
  final String storeName;
  const StoreDetailScreen(
      {super.key, required this.storeID, required this.storeName});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        label: localizations!.offers,
        activeIcon: SvgPicture.asset(
          width: 30,
          colorFilter:  ColorFilter.mode(Theme.of(context).primaryIconTheme.color!, BlendMode.srcIn),
          'assets/svg/Special_Offers.svg',
        ),
        icon: SvgPicture.asset(
          width: 30,
          'assets/svg/Special_Offers.svg',
        ),
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          colorFilter:  ColorFilter.mode(Theme.of(context).primaryIconTheme.color!, BlendMode.srcIn),
          width: 30,
          'assets/svg/coupon.svg',
        ),
        label: localizations.vouchers,
        icon: SvgPicture.asset(
          colorFilter: ColorFilter.mode(Theme.of(context).primaryIconTheme.color!, BlendMode.srcIn),
          width: 30,
          'assets/svg/coupon.svg',
        ),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? '${widget.storeName} ${localizations.offers}'
              : '${widget.storeName} ${localizations.vouchers}',
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.pointCardColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Text(
                    localizations.points,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  BlocBuilder<StoresBloc, StoresState>(
                    builder: (context, state) {
                      return Text(
                        CacheManager.getPoint().toString(),
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: selectedIndex == 0
          ? StoreOffer(
              storeID: widget.storeID,
            )
          : StoreVouchers(
              storeID: widget.storeID,
              storeName: widget.storeName,
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        selectedLabelStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        selectedItemColor: Theme.of(context).primaryIconTheme.color,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        showSelectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(
            () {
              selectedIndex = value;
            },
          );
        },
      ),
    );
  }
}
