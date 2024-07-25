

import '../../constant/imports.dart';

// ignore: must_be_immutable
class CharityGrid extends StatelessWidget {
   List<CharityModel> charities;
   CharityGrid({super.key, required this.charities});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: charities.length,
      itemBuilder: (ctx, i) => CharityItem(
        charity: charities[i],
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.88,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
