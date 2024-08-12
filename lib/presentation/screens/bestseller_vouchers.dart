import 'package:loyalty_system_mobile/data/models/bestsellervoucher_model.dart';
import 'package:loyalty_system_mobile/presentation/widgets/best_item.dart';

import '../../constant/imports.dart';

class BestsellerVouchers extends StatefulWidget {
  const BestsellerVouchers({
    super.key,
  });
  @override
  State<BestsellerVouchers> createState() => _BestsellerVouchers();
}

class _BestsellerVouchers extends State<BestsellerVouchers> {
  late Bloc homebloc;
  List<BestSellerModel> vouchers = [];
  @override
  void initState() {
    homebloc = BlocProvider.of<HomeBloc>(context);
    homebloc.add(GetBestsellerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        title: Text(
          localizations!.bestsellervoucher,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is BestSellerLoadedState) {
            vouchers = state.vouchers;
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is BestSellerLoadedState) {
              return vouchers.isEmpty
                  ? const Center(
                      child:
                          Text('localizations!.thisstoredoesnothavevouchers'),
                    )
                  : ListView.builder(
                      itemCount: vouchers.length,
                      itemBuilder: (context, index) => BestSellerVoucherItem(
                        voucher: vouchers[index],
                      ),
                    );
            } else if (state is BestSellerFailedState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.somthingwentwrong,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.restart_alt_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      homebloc.add(
                        GetBestsellerEvent(),
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
      ),
    );
  }
}
