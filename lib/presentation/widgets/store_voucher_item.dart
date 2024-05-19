import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';

class StoreVoucherItem extends StatelessWidget {
  final StoreVoucherModel storeVoucherModel;
  final String storeName;
  const StoreVoucherItem(
      {super.key, required this.storeVoucherModel, required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 244, 240),
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
                  storeVoucherModel.name,
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
                              title: Text(
                                'Bying Voucher',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              content: Text(
                                  'Are you sure you want to buy this voucher',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  )),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkGray),
                                  onPressed: () {},
                                  child: Text(
                                    'Yes',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.darkGray),
                                    onPressed: () {},
                                    child: Text(
                                      'No',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )),
                              ],
                            ));
                  },
                  child: Text(
                    'Get Voucher',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
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
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/voucher.png',
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
                              border:
                                  Border.all(width: 0.6, color: Colors.black),
                            ),
                            child: Text(
                              '20-4-2020',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                storeVoucherModel.points.toString(),
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: AppColors.green,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                'points',
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
                                '${storeVoucherModel.discount}%',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const Text(
                                'discount',
                                style: TextStyle(
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
                            storeVoucherModel.description,
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
