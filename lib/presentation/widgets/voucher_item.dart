import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/voucher_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loyalty_system_mobile/logic/home/bloc/home_bloc.dart';
import 'package:quickalert/quickalert.dart';

class VoucherItem extends StatelessWidget {
  final VoucherModel voucher;
  const VoucherItem({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final Locale appLocale = Localizations.localeOf(context);
    Bloc homebloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
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
                      textStyle: const TextStyle(fontWeight: FontWeight.w700),
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
                            'Consuming Voucher',
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to consume the voucher',
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
                                // TransferRepository transferRepository =
                                //     TransferRepository(
                                //   ExternalService(),
                                // );
                                // String response =
                                //     await transferRepository.useVoucher(
                                //   {},
                                //   'use_voucher/${voucher.id}',
                                // );
                                // if (response.contains('message')) {
                                //   if (!context.mounted) return;
                                //   Navigator.pop(context);
                                //   QuickAlert.show(
                                //       context: context,
                                //       type: QuickAlertType.error,
                                //       title: response,
                                //       confirmBtnColor: AppColors.buttonColor,
                                //       onConfirmBtnTap: () {
                                //         Navigator.of(context).pop();
                                //         bloc.add(GetHomeDateEvent());
                                //       });
                                // } else {
                                //   if (!context.mounted) return;
      
                                //   Navigator.pop(context);
                                //   QuickAlert.show(
                                //       context: context,
                                //       type: QuickAlertType.success,
                                //       title: response,
                                //       confirmBtnColor: AppColors.buttonColor,
                                //       onConfirmBtnTap: () {
                                //         Navigator.of(context).pop();
                                //         bloc.add(GetHomeDateEvent());
                                //       });
                                // }
                              },
                              child: BlocConsumer<HomeBloc, HomeState>(
                                buildWhen: (previous, current) =>
                                    current is ConsumingLoaadingState,
                                builder: (context, state) {
                                  if (state is ConsumingLoaadingState) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return Text(
                                      'yes',
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
                                      titleColor: Theme.of(context)
                                          .primaryIconTheme
                                          .color!,
                                      text: 'Give this otp to the cashier',
                                      textColor: Theme.of(context)
                                          .primaryIconTheme
                                          .color!,
                                      confirmBtnColor: AppColors.buttonColor,
                                      onConfirmBtnTap: () {
                                        Navigator.pop(context);
                                        homebloc.add(GetHomeDateEvent());
                                        Navigator.pop(context);
                                      },
                                    );
                                  } else if (state is ConsumingFailedState) {
                                    Navigator.of(context).pop();
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title: 'Failed',
                                      text: state.errorMessage,
                                      confirmBtnColor: AppColors.buttonColor,
                                    );
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
                                localizations!.no,
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
                      'Use Voucher',
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
                        width: 85,
                        height: 150,
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
                                DateFormat('yyyy-MM-dd').format(voucher.expDate),
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
                                  localizations!.point,
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
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      SizedBox(
                        width: 150,
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
