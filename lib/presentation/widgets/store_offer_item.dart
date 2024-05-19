// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/offer_model.dart';

class StoreOfferItem extends StatelessWidget {
  final OfferModel offer;
  const StoreOfferItem({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.green, borderRadius: BorderRadius.circular(8)),
              child: Text(
                'valid until ${DateFormat('yyyy-MM-dd').format(offer.endsIn)}',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.cyan,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white60),
                    child: Center(
                      child: Text(
                        '${offer.points}P',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColors.appBarColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 50,
                    
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white60,
                    ),
                    child: Center(
                      child: Text(
                        'offer.description omran asom as as amn kadnasjkdna s dasdkmd aksd asd jknamsdm aks',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 11,
                              color: AppColors.appBarColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
