import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
//import 'package:project_2/Provider/products_provider.dart';

class CharityItem extends StatelessWidget {
  const CharityItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   '/product_detail',
        //   arguments: product.id,
        // );
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile.jpg'),
                        fit: BoxFit.cover,
                        // image: product.imageURL != null
                        //     ? CachedNetworkImageProvider(
                        //         'http://$host/${product.imageURL![0]}',
                        //       )
                        //     : const AssetImage(
                        //             'asset/images/productholedr.png')
                        //         as ImageProvider),
                      ),
                    ),
                    width: double.infinity,
                    height: 99,
                  ),
                ),
                // product.colorandsize!.isNotEmpty
                // ? const Center()
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
                      ' The green ground',
                      // product.name![0].toUpperCase() +
                      //     product.name!.substring(1),
                      style: GoogleFonts.montserrat(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
