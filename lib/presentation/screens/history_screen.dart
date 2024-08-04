import '../../constant/imports.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Bloc historyBloc;
  List<PointHistoryModel> historyList = [];
  @override
  void initState() {
    historyBloc = BlocProvider.of<HistoryBloc>(context);
    historyBloc.add(LoadHistoryEvent());
    super.initState();
  }

  Future<void> reGet() async {
    historyBloc.add(LoadHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          localizations!.transactionshistory,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: BlocListener<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryLoaddedState) {
            historyList = state.historyList;
          }
        },
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoaddedState) {
              return RefreshIndicator(
                onRefresh: () => reGet(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${localizations.numberoftransactions} ${historyList.length}',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.78,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: historyList.length,
                        itemBuilder: ((ctx, i) => HistoryItem(
                              history: historyList[i],
                            )),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is HistoryFaildState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor),
                      onPressed: () {
                        historyBloc.add(LoadHistoryEvent());
                      },
                      label: Text(
                        localizations.regetdata,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Image.asset('assets/images/loading.gif'),
              );
            }
          },
        ),
      ),
    );
  }
}
