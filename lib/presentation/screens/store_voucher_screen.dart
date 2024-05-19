import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_voucher_item.dart';

class StoreVoucherScreen extends StatelessWidget {
  final List<StoreVoucherModel> vouchers;
  final String name;
  const StoreVoucherScreen(
      {super.key, required this.vouchers, required this.name});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) => StoreVoucherItem(
        storeVoucherModel: vouchers[i],
        storeName: name,
      ),
      itemCount: vouchers.length,
    );
  }
}
