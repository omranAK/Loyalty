import 'package:loyalty_system_mobile/data/models/bestsellervoucher_model.dart';
import '../../constant/imports.dart';

class BestSellerVoucherItem extends StatelessWidget {
  final BestSellerModel voucher;
  const BestSellerVoucherItem({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final Locale appLocale = Localizations.localeOf(context);
    Bloc storeBloc = BlocProvider.of<StoresBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0),
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
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
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
                      getVoucherDialog(context, localizations, storeBloc);
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
                height: 150,
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
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${voucher.points}',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: AppColors.green,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                Text(
                                  localizations.point,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: AppColors.green,
                                        fontSize: 10,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  localizations.discount,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: appLocale == const Locale('ar')
                              ? EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * 0.05)
                              : EdgeInsets.only(
                                  right:
                                      MediaQuery.sizeOf(context).width * 0.05),
                          child: Align(
                            alignment: appLocale == const Locale('ar')
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    voucher.storeNmae,
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
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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

  Future<dynamic> getVoucherDialog(BuildContext context,
      AppLocalizations localizations, Bloc<dynamic, dynamic> storeBloc) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        title: Text(
          localizations.getvoucher,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          localizations.areyousureyouwanttobuythisvoucher,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        actions: [
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.darkGray),
            onPressed: () async {
              storeBloc.add(
                BuyVoucherButtonPressedEvent(
                  voucherID: voucher.id,
                  points: voucher.points,
                ),
              );
            },
            child: BlocConsumer<StoresBloc, StoresState>(
              buildWhen: (previous, current) => current is BuyingLoadingState,
              builder: (context, state) {
                if (state is BuyingLoadingState) {
                  return CircularProgressIndicator(
                    color: Theme.of(context).badgeTheme.backgroundColor,
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
              listenWhen: (previous, current) => previous is BuyingLoadingState,
              listener: (context, state) {
                if (state is BuyingSuccessState) {
                  Navigator.of(context).pop();
                  QuickAlert.show(
                      backgroundColor: Theme.of(context).cardColor,
                      context: context,
                      type: QuickAlertType.success,
                      titleColor: Theme.of(context).primaryIconTheme.color!,
                      title: localizations.success,
                      textColor: Theme.of(context).primaryIconTheme.color!,
                      text: 'You can use it within the valid period',
                      confirmBtnColor: AppColors.buttonColor,
                      confirmBtnText: localizations.done);
                } else if (state is BuyingFailedState) {
                  Navigator.of(context).pop();
                  QuickAlert.show(
                      backgroundColor: Theme.of(context).cardColor,
                      context: context,
                      type: QuickAlertType.error,
                      titleColor: Theme.of(context).primaryIconTheme.color!,
                      title: localizations.failed,
                      textColor: Theme.of(context).primaryIconTheme.color!,
                      text: state.errorMessage,
                      confirmBtnColor: AppColors.buttonColor,
                      confirmBtnText: localizations.done);
                }
              },
            ),
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.darkGray),
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
  }
}
