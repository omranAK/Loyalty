import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_offer_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_voucher_screen.dart';

class StoreDetailScreen extends StatefulWidget {
  const StoreDetailScreen({super.key});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  int selectedIndex = 0;
  final screens = [
    const StoreOffer(),
    const StoreVoucherScreen(),
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      label: 'Offers',
      activeIcon: SvgPicture.asset(
        width: 35,
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        'assets/svg/Special_Offers.svg',
      ),
      icon: SvgPicture.asset(
        width: 10,
        height: 35,
        'assets/svg/Special_Offers.svg',
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        width: 40,
        'assets/svg/coupon.svg',
      ),
      label: 'Vouchers',
      icon: SvgPicture.asset(
        width: 40,
        'assets/svg/coupon.svg',
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        selectedLabelStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        selectedItemColor: Colors.black,
        backgroundColor: AppColors.lightGreen,
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
