import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/constant/constant_data.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:project_2/Provider/products_provider.dart';

class CharityItem extends StatelessWidget {
  final CharityModel charity;
  const CharityItem({super.key, required this.charity});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          charitydetaile,
          arguments: charity,
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.38,
        height: MediaQuery.sizeOf(context).height * 0.20,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.lightGreen,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:const  BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image:charity.prof_img!=null? CachedNetworkImageProvider(
                            'http://jamal.savoiacar.com/${charity.prof_img}'):const AssetImage('assets/images/EmptyCharity.jpg')as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    height: 99,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      charity.name,
                      // product.name![0].toUpperCase() +
                      //     product.name!.substring(1),
                      style: GoogleFonts.montserrat(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: width * 0.6,
                    child: Text(
                      charity.description,
                      // product.name![0].toUpperCase() +
                      //     product.name!.substring(1),
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
