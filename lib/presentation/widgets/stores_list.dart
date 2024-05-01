// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_item.dart';

// ignore: must_be_immutable
class StoresList extends StatefulWidget {
  const StoresList({
    Key? key,
  }) : super(key: key);
  @override
  State<StoresList> createState() => _StoresListState();
}

class _StoresListState extends State<StoresList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: ((ctx, i) => const StoreItem()));
    // : FutureBuilder(
    //     future: Provider.of<Stores>(context, listen: false)
    //         .findByLocation(widget.location!),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else {
    //         return ListView.builder(
    //           padding: const EdgeInsets.all(8),
    //           scrollDirection: Axis.vertical,
    //           itemCount: snapshot.data!.length,
    //           itemBuilder: ((ctx, i) => ChangeNotifierProvider.value(
    //                 value: snapshot.data![i],
    //                 child: const StoreItem(),
    //               )),
    //         );
    //       }
    //     },
    //   );
  }
}
