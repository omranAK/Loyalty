import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/presentation/widgets/charity_item.dart';

// ignore: must_be_immutable
class CharityGrid extends StatelessWidget {
  const CharityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: 10,
      itemBuilder: (ctx, i) => const CharityItem(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
