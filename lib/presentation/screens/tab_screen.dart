

import '../../constant/imports.dart';

class Tabs extends StatefulWidget {
  static const routename = '/tabs';
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int selectedIndex = 0;
  final screens = [
    const HomeScreen(),
    const StoresScreen(),
    if (CacheManager.getUserModel()!.roleID == 4) const TransferScreen(),
    if (CacheManager.getUserModel()!.roleID == 4) const CharityScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).primaryIconTheme.color;
    final localizations = AppLocalizations.of(context);
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, color: iconColor),
          label: localizations!.home),
      BottomNavigationBarItem(
          icon: Icon(Icons.store_outlined, color: iconColor),
          label: localizations.stores),
      if (CacheManager.getUserModel()!.roleID == 4)
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/transfer.svg',
              colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
            ),
            label: localizations.transferpoints),
      if (CacheManager.getUserModel()!.roleID == 4)
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/charity.svg',
            colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
          ),
          label: localizations.charity,
        ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history, color: iconColor),
        label: localizations.transactionshistory,
      ),
    ];
    return PopScope(
      //canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
        
          backgroundColor: Theme.of(context).colorScheme.background,
          items: items,
          selectedLabelStyle: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
          selectedItemColor: iconColor,
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
