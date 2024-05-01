import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/constant/constant_data.dart';

class StoreItem extends StatefulWidget {
  const StoreItem({super.key});

  @override
  State<StoreItem> createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, storeDetail);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            LimitedBox(
              maxWidth: MediaQuery.sizeOf(context).width * 0.95,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.1,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.green),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                        width: 90,
                        height: 90,
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/profile.jpg'),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'omran alakad',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                color: Colors.black45,
                                size: 18,
                              ),
                              Text('', style: TextStyle(fontSize: 16))
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.category,
                                color: Colors.black45,
                                size: 18,
                              ),
                              Text('store.catogries')
                            ],
                          )
                        ],
                      ),
                    ),
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
