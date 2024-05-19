import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/data/models/offer_model.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_offer_item.dart';

class StoreOffer extends StatelessWidget {
  final List<OfferModel> offers;
  const StoreOffer({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 2)),
      height: 250,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 150,
              width: double.infinity,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/profile.jpg',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          ListTile(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My name is omran',style: GoogleFonts.montserrat(fontSize:16),),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.',style: GoogleFonts.montserrat(fontSize:12)),
              ],
            ),
          
            trailing: Align(alignment: Alignment.topRight,child: Text('400 P',style: TextStyle(fontSize:16 ),)),
          )
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: GridView.custom(
    //     gridDelegate: SliverWovenGridDelegate.count(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 0,
    //       crossAxisSpacing: 0,
    //       pattern: const [
    //         WovenGridTile(1),
    //         WovenGridTile(
    //           5 / 7,
    //           crossAxisRatio: 0.9,
    //           alignment: AlignmentDirectional.centerEnd,
    //         ),
    //       ],
    //     ),
    //     childrenDelegate: SliverChildBuilderDelegate(
    //       childCount: 10,
    //       (context, index) => StoreOfferItem(
    //         offer: offers[0],
    //       ),
    //     ),
    //   ),
    // );
  }
}
