import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_voucher_item.dart';

class StoreVouchers extends StatelessWidget {
  final List<StoreVoucherModel> vouchers;
  final String storeName;
  const StoreVouchers(
      {super.key, required this.vouchers, required this.storeName});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: vouchers.length,
        itemBuilder: (context, index) => StoreVoucherItem(
              voucher: vouchers[index],
              storeName: storeName,
            ));
  }
}
