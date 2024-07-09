import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_system_mobile/data/models/offer_model.dart';
import 'package:loyalty_system_mobile/logic/stores/bloc/stores_bloc.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_offer_item.dart';

class StoreOffer extends StatefulWidget {
  final int storeID;
  const StoreOffer({super.key, required this.storeID});

  @override
  State<StoreOffer> createState() => _StoreOfferState();
}

class _StoreOfferState extends State<StoreOffer> {
  late Bloc storeBloc;
  List<OfferModel> offers = [];
  @override
  void initState() {
    storeBloc = BlocProvider.of<StoresBloc>(context);
    storeBloc.add(LoadStoreOffersEvent(storeID: widget.storeID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoresBloc, StoresState>(
      listener: (context, state) {
        if (state is OffersLoaddedState) {
          offers = state.offers;
        }
      },
      child: BlocBuilder<StoresBloc, StoresState>(
        builder: (context, state) {
          if (state is OffersLoaddedState) {
            return offers.isEmpty
                ? const Center(
                    child: Text('This store does not have offers'),
                  )
                : ListView.builder(
                    itemCount: state.offers.length,
                    itemBuilder: (context, index) => StoreOfferItem(
                      offer: offers[index],
                    ),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
