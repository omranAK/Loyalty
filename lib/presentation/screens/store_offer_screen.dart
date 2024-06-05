import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loyalty_system_mobile/data/models/offer_model.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_offer_item.dart';

class StoreOffer extends StatelessWidget {
  final List<OfferModel> offers;
  const StoreOffer({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (context, index) => StoreOfferItem(
        offer: offers[index],
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
