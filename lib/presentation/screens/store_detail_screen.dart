import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/offer_model.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/logic/stores/bloc/stores_bloc.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_offer_screen.dart';
import 'package:loyalty_system_mobile/presentation/screens/store_voucher_screen.dart';

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
  late List<OfferModel> offers;
  late List<StoreVoucherModel> vouchers;
  late Bloc storeBloc;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      label: 'Offers',
      activeIcon: SvgPicture.asset(
        width: 30,
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        'assets/svg/Special_Offers.svg',
      ),
      icon: SvgPicture.asset(
        width: 30,
        'assets/svg/Special_Offers.svg',
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        width: 30,
        'assets/svg/coupon.svg',
      ),
      label: 'Vouchers',
      icon: SvgPicture.asset(
        width: 30,
        'assets/svg/coupon.svg',
      ),
    )
  ];
  @override
  void initState() {
    storeBloc = BlocProvider.of<StoresBloc>(context);
    storeBloc.add(LoadStoreDetailesEvent(storeID: widget.storeID));
    super.initState();
  }

  Future<void> reGet() async {
    storeBloc.add(LoadStoreDetailesEvent(storeID: widget.storeID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? '${widget.storeName} offers'
              : '${widget.storeName} vouchers',
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
                    'My Points ',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                  Text(
                    CacheManager.getPoint().toString(),
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => reGet(),
        child: BlocBuilder<StoresBloc, StoresState>(
          builder: (context, state) {
            if (state is DetailesLoaddedState) {
              offers = state.offers;
              vouchers = state.vouchers;
              return selectedIndex == 0
                  ? StoreOffer(offers: offers)
                  : StoreVoucherScreen(
                      vouchers: vouchers,
                      name: widget.storeName,
                    );
            } else if (state is DetailesFaildState) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
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
