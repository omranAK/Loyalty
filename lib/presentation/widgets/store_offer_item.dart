// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
    List<Image> images = [];
    offer.imageList.forEach(
      (element) {
        images.add(
          Image.network(
            'http://10.0.2.2:8000/$element',
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2)),
        height: 250,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AnotherCarousel(
                      images: images,
                      dotSize: 3,
                      indicatorBgPadding: 5,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'valid until ${DateFormat('yyyy-MM-dd').format(offer.endsIn)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    offer.name.toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontSize: 16, decoration: TextDecoration.underline),
                  ),
                  Text(
                    '${offer.points} P',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0, left: 2, right: 2),
              child: Text(
                offer.description,
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(15),
    //     image: DecorationImage(
    //         image: AssetImage('assets/images/profile.jpg'),
    //         fit: BoxFit.cover),
    //     color: Colors.black,
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //               color: AppColors.green, borderRadius: BorderRadius.circular(8)),
    //           child: Text(
    //             'valid until ${DateFormat('yyyy-MM-dd').format(offer.endsIn)}',
    //             style: GoogleFonts.montserrat(
    //               fontSize: 16,
    //               color: Colors.white,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Container(
    //                 width: 60,
    //                 height: 30,
    //                 decoration: BoxDecoration(
    //                     border: Border.all(
    //                       color: Colors.cyan,
    //                     ),
    //                     borderRadius: BorderRadius.circular(5),
    //                     color: Colors.white60),
    //                 child: Center(
    //                   child: Text(
    //                     '${offer.points}P',
    //                     style: GoogleFonts.montserrat(
    //                       textStyle: const TextStyle(
    //                           fontSize: 16,
    //                           color: AppColors.appBarColor,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Flexible(
    //               child: Container(
    //                 height: 50,

    //                 decoration: BoxDecoration(
    //                   border: Border.all(color: Colors.cyan),
    //                   borderRadius: BorderRadius.circular(5),
    //                   color: Colors.white60,
    //                 ),
    //                 child: Center(
    //                   child: Text(
    //                     'offer.description omran asom as as amn kadnasjkdna s dasdkmd aksd asd jknamsdm aks',
    //                     style: GoogleFonts.montserrat(
    //                       textStyle: const TextStyle(
    //                           fontSize: 11,
    //                           color: AppColors.appBarColor,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
