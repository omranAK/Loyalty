// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';

import '../../constant/imports.dart';

class StoreOfferItem extends StatelessWidget {
  final OfferModel offer;
  const StoreOfferItem({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final height = MediaQuery.sizeOf(context).height;
    List<CachedNetworkImage> images = [];
    for (var element in offer.imageList) {
      images.add(
        CachedNetworkImage(
          imageUrl: '${ServerConfig.mainApiUrlImage}$element',
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Image.asset(
             'assets/images/offer.png'),
          fit: BoxFit.cover,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2),
        ),
        height: height * 0.28,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AnotherCarousel(
                      images: images,
                      dotSize: 3,
                      indicatorBgPadding: 5,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).bannerTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        '${localizations!.validuntil} ${DateFormat('yyyy-MM-dd').format(offer.endsIn)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    offer.name.toUpperCase(),
                    style: GoogleFonts.montserrat(
                        fontSize: 16, decoration: TextDecoration.underline),
                  ),
                  Text(
                    '${offer.points} P',
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0, left: 2, right: 2),
              child: Text(
                offer.description,
                style: GoogleFonts.montserrat(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
