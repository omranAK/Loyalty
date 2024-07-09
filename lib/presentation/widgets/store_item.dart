import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/constant/constant_data.dart';
import 'package:loyalty_system_mobile/data/models/store_model.dart';

class StoreItem extends StatelessWidget {
  final StoreModel store;
  const StoreItem({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, storeDetail,
            arguments: {'storeID': store.id, 'name': store.name});
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            LimitedBox(
              maxWidth: MediaQuery.sizeOf(context).width * 0.95,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.11,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 90,
                      child: store.prof_img == null
                          ? Image.asset(
                              'assets/images/logo.png',
                              color: Colors.black,
                            )
                          : Image.network(
                              fit: BoxFit.cover,
                              'http://jamal.savoiacar.com/${store.prof_img}',
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              store.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.black45,
                                size: 18,
                              ),
                              Text(
                                store.phone.toUpperCase(),
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.category,
                                color: Colors.black45,
                                size: 18,
                              ),
                              Text(
                                store.category.toUpperCase(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              const Text(
                                'LOCATION',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(store.location),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
