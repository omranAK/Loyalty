import '../../constant/imports.dart';

class StoreItem extends StatelessWidget {
  final StoreModel store;
  const StoreItem({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
              maxWidth: width * 0.95,
              child: Container(
                height: height * 0.11,
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 2, color: Theme.of(context).cardColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      height: 90,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ServerConfig.mainApiUrlImage}${store.profImg}',
                        placeholder: (context, url) =>
                            Image.asset('assets/images/imageLoading.gif'),
                        errorWidget: (context, url, error) =>  Icon(
                          Icons.store,
                          size: 80,
                          color: Theme.of(context).badgeTheme.backgroundColor,
                        ),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
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
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            localizations!.location,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(store.location),
                          ),
                        ],
                      ),
                    )
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
