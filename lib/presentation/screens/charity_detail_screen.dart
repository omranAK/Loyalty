import '../../constant/imports.dart';

class CharityDetailScreen extends StatelessWidget {
  final CharityModel charity;
  const CharityDetailScreen({
    super.key,
    required this.charity,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    TextEditingController ammountController = TextEditingController();
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(charity.name),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.pointCardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    localizations!.myspicialpoints,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  BlocBuilder<CharityBloc, CharityState>(
                    builder: (context, state) {
                      return Text(
                        CacheManager.getSpicialPoint().toString(),
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                localizations.donate,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleMedium!.color),
                ),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    localizations.ammount,
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: ammountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(top: 0, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGray),
                  onPressed: () {
                    ammountController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    localizations.cancel,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green),
                  onPressed: () async {
                    BlocProvider.of<CharityBloc>(context).add(
                      DonateSpicialPointsEvent(
                        charity.id,
                        ammount: ammountController.text,
                      ),
                    );
                  },
                  child: BlocConsumer<CharityBloc, CharityState>(
                    listener: (context, state) {
                      if (state is DonateDoneState) {
                        ammountController.clear();
                        Navigator.of(context).pop();
                        QuickAlert.show(
                            context: context,
                            backgroundColor: Theme.of(context).cardColor,
                            type: QuickAlertType.success,
                            title: localizations.success,
                            titleColor:
                                Theme.of(context).primaryIconTheme.color!,
                            confirmBtnColor: AppColors.buttonColor,
                            confirmBtnText: localizations.done);
                      } else if (state is DonateFailedState) {
                        ammountController.clear();
                        Navigator.of(context).pop();
                        QuickAlert.show(
                            context: context,
                            backgroundColor: Theme.of(context).cardColor,
                            type: QuickAlertType.error,
                            title: localizations.failed,
                            titleColor:
                                Theme.of(context).primaryIconTheme.color!,
                            textColor:
                                Theme.of(context).primaryIconTheme.color!,
                            text: state.errorMessage,
                            confirmBtnColor: AppColors.buttonColor,
                            confirmBtnText: localizations.done);
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is DonateLoadingState,
                    builder: (context, state) {
                      if (state is DonateLoadingState) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).badgeTheme.backgroundColor,
                        );
                      } else {
                        return Text(
                          localizations.procced,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        label: Text(localizations.donate),
        icon: const Icon(Icons.handshake),
      ),
      body: ListView(
        children: [
          // Charity image
          charity.profImg != null
              ? CachedNetworkImage(
                  imageUrl: '${ServerConfig.mainApiUrlImage}${charity.profImg}',
                  height: height / 1.8,
                  fit: BoxFit.fill,
                )
              : Image.asset('assets/images/EmptyCharity.jpg'),

          // Charity title
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(
              charity.name.toUpperCase(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),

          //charity Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(charity.description),
          ),
        ],
      ),
    );
  }
}
