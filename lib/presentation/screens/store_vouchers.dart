import '../../constant/imports.dart';

class StoreVouchers extends StatefulWidget {
  final int storeID;
  final String storeName;
  const StoreVouchers(
      {super.key, required this.storeID, required this.storeName});

  @override
  State<StoreVouchers> createState() => _StoreVouchersState();
}

class _StoreVouchersState extends State<StoreVouchers> {
  late Bloc storeBloc;
  List<StoreVoucherModel> vouchers = [];
  @override
  void initState() {
    storeBloc = BlocProvider.of<StoresBloc>(context);
    storeBloc.add(LoadStoreVouchersEvent(storeID: widget.storeID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return BlocListener<StoresBloc, StoresState>(
      listener: (context, state) {
        if (state is VouchersLoaddedState) {
          vouchers = state.vouchers;
        }
      },
      child: BlocBuilder<StoresBloc, StoresState>(
        buildWhen: (previous, current) => current is VouchersLoaddedState,
        builder: (context, state) {
          if (state is VouchersLoaddedState) {
            return vouchers.isEmpty
                ? Center(
                    child: Text(localizations!.thisstoredoesnothavevouchers),
                  )
                : ListView.builder(
                    itemCount: vouchers.length,
                    itemBuilder: (context, index) => storeVoucherItem(
                      vouchers[index],
                      widget.storeName,
                    ),
                  );
          } else if (state is VocuhersFailedState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations!.somthingwentwrong,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.restart_alt_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    storeBloc.add(
                      LoadStoreVouchersEvent(storeID: widget.storeID),
                    );
                  },
                  label: Text(
                    localizations.regetdata,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).badgeTheme.backgroundColor,
              ),
            );
          }
        },
      ),
    );
  }

  Widget storeVoucherItem(StoreVoucherModel voucher, String storeName) {
    final localizations = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final Locale appLocale = Localizations.localeOf(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 8.0,right: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    voucher.name,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.darkGray,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          title: Text(
                            localizations.getvoucher,
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Text(
                            localizations.areyousureyouwanttobuythisvoucher,
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkGray),
                              onPressed: () async {
                                storeBloc.add(
                                  BuyVoucherButtonPressedEvent(
                                    voucherID: voucher.id,
                                    points: voucher.points,
                                  ),
                                );
                              },
                              child: BlocConsumer<StoresBloc, StoresState>(
                                buildWhen: (previous, current) =>
                                    current is BuyingLoadingState,
                                builder: (context, state) {
                                  if (state is BuyingLoadingState) {
                                    return CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .badgeTheme
                                          .backgroundColor,
                                    );
                                  } else {
                                    return Text(
                                      localizations.yes,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }
                                },
                                listenWhen: (previous, current) =>
                                    previous is BuyingLoadingState,
                                listener: (context, state) {
                                  if (state is BuyingSuccessState) {
                                    Navigator.of(context).pop();
                                    QuickAlert.show(
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        context: context,
                                        type: QuickAlertType.success,
                                        titleColor: Theme.of(context)
                                            .primaryIconTheme
                                            .color!,
                                        title: localizations.success,
                                        textColor: Theme.of(context)
                                            .primaryIconTheme
                                            .color!,
                                        text:
                                            'You can use it within the valid period',
                                        confirmBtnColor: AppColors.buttonColor,
                                        confirmBtnText: localizations.done);
                                  } else if (state is BuyingFailedState) {
                                    Navigator.of(context).pop();
                                    QuickAlert.show(
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        context: context,
                                        type: QuickAlertType.error,
                                        titleColor: Theme.of(context)
                                            .primaryIconTheme
                                            .color!,
                                        title: localizations.failed,
                                        textColor: Theme.of(context)
                                            .primaryIconTheme
                                            .color!,
                                        text: state.errorMessage,
                                        confirmBtnColor: AppColors.buttonColor,
                                        confirmBtnText: localizations.done);
                                  }
                                },
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkGray),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                localizations.no,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      localizations!.getvoucher,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: height * 0.18,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      appLocale == const Locale('ar')
                          ? 'assets/images/flippedVoucher.png'
                          : 'assets/images/voucher.png',
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.22,
                        //height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  voucher.points.toString(),
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: AppColors.green,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Text(
                                  localizations.point,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: AppColors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${voucher.discount}%',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  localizations.discount,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.2,
                      ),
                      SizedBox(
                        width: width * 0.4,
                        //height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              storeName.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(235, 197, 95, 1),
                                ),
                              ),
                            ),
                            Text(
                              voucher.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 11),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
