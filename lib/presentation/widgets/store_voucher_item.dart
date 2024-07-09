import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreVoucherItem extends StatelessWidget {
  final StoreVoucherModel voucher;
  final String storeName;
  const StoreVoucherItem({
    super.key,
    required this.voucher,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final Locale appLocale = Localizations.localeOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
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
                        color: AppColors.pointCardColor,
                        fontWeight: FontWeight.w700),
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
                        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
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
                                
                                // StoreRepository storeRepository =
                                //     StoreRepository(
                                //   externalService: ExternalService(),
                                // );
                                // var response = await storeRepository.buyVoucher(
                                //     {},
                                //     'buy_voucher/${voucher.id}',
                                //     voucher.points);
                                // if (response == 'success') {
                                //   if (!context.mounted) return;
                                //   Navigator.pop(context);
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       backgroundColor: Colors.green,
                                //       content: Text(localizations
                                //           .donenowyoucanuseyourvoucher),
                                //     ),
                                //   );
                                // } else {
                                //   if (!context.mounted) return;
                                //   Navigator.pop(context);
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(response),
                                //     ),
                                //   );
                                // }
                              },
                              child: Text(
                                localizations.yes,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
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
                                    fontWeight: FontWeight.w400),
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
                                      fontWeight: FontWeight.w800),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                localizations.discount,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
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
    );
  }
}
