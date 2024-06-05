import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/presentation/screens/charit_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/history_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/stores_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/transfer_screen.dart';
import '../Screens/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tabs extends StatefulWidget {
  static const routename = '/tabs';
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // var _isInit = true;
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     Provider.of<Products>(context, listen: false).fetchingdata();
  //     Provider.of<Stores>(context, listen: false).fetchingData();
  //     Provider.of<Profile>(context, listen: false).fetchingdata();
  //     Provider.of<Orders>(context, listen: false).fetchingdata();
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
  int selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const StoresScreen(),
    const TransferScreen(),
    if (CacheManager.getUserModel()!.roleID == 4)const  CharityScreen(),
    const HistoryScreen(),
  ];
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled, color: Colors.black), label: 'home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.store_outlined, color: Colors.black), label: 'stores'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset('assets/svg/transfer.svg'), label: 'transfer'),
    if (CacheManager.getUserModel()!.roleID == 4)
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svg/charity.svg'), label: 'charity'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.history, color: Colors.black), label: 'history'),
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          selectedLabelStyle: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
          selectedItemColor: Colors.black,
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
      ),
    );
  }
}
