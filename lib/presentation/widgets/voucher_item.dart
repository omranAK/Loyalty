import 'package:easy_localization/easy_localization.dart';
import '../../constant/imports.dart';

class VoucherItem extends StatelessWidget {
  final VoucherModel voucher;
  const VoucherItem({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final Locale appLocale = Localizations.localeOf(context);
    Bloc homebloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
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
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          title: Text(
                            localizations.consumevoucher,
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Text(
                            localizations.areyousureyouwanttoconsumethevoucher,
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGray,
                              ),
                              onPressed: () async {
                                homebloc.add(
                                  ConsumeVoucherEvent(voucherID: voucher.id),
                                );
                              },
                              child: BlocConsumer<HomeBloc, HomeState>(
                                buildWhen: (previous, current) =>
                                    current is ConsumingLoaadingState,
                                builder: (context, state) {
                                  if (state is ConsumingLoaadingState) {
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
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                listenWhen: (previous, current) =>
                                    previous is ConsumingLoaadingState,
                                listener: (context, state) {
                                  if (state is ConsumingSuccessState) {
                                    // Navigator.of(context).pop();
                                    QuickAlert.show(
                                      context: context,
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      type: QuickAlertType.success,
                                      title: state.otp,
                                      titleColor:
                                          Theme.of(context).primaryColor,
                                      text:
                                          localizations.givethisotptothecashier,
                                      textColor: Theme.of(context).primaryColor,
                                      confirmBtnColor: AppColors.buttonColor,
                                      confirmBtnText: localizations.done,
                                      onConfirmBtnTap: () {
                                        Navigator.pop(context);
                                        homebloc.add(GetHomeDateEvent());
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (state is ConsumingFailedState) {
                                    Navigator.of(context).pop();
                                    QuickAlert.show(
                                        backgroundColor:
                                            Theme.of(context).cardColor,
                                        context: context,
                                        type: QuickAlertType.error,
                                        titleColor:
                                            Theme.of(context).primaryColor,
                                        title: localizations.failed,
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        text: state.errorMessage,
                                        confirmBtnColor: AppColors.buttonColor,
                                        confirmBtnText: localizations.done);
                                  }
                                },
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkGray,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                localizations.no,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      localizations!.consumevoucher,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
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
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.6,
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(voucher.expDate),
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
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
}
