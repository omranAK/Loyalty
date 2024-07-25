import '../../constant/imports.dart';

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
    final localizations = AppLocalizations.of(context);

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
                ? Center(
                    child: Text(localizations!.thisstoredoesnothaveoffers),
                  )
                : ListView.builder(
                    itemCount: state.offers.length,
                    itemBuilder: (context, index) => StoreOfferItem(
                      offer: offers[index],
                    ),
                  );
          } else if (state is OffersFailedState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations!.somthingwentwrong,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.restart_alt_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    storeBloc.add(
                      LoadStoreOffersEvent(storeID: widget.storeID),
                    );
                  },
                  label: Text(
                    localizations.regetdata,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).badgeTheme.backgroundColor,
              ),
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
