import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/point_history_model.dart';
import 'package:loyalty_system_mobile/logic/history/bloc/history_bloc.dart';
import 'package:loyalty_system_mobile/presentation/widgets/history_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            historyList = state.history_list;
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
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.73,
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
                      icon: const Icon(Icons.restart_alt_outlined),
                      onPressed: () {
                        historyBloc.add(LoadHistoryEvent());
                      },
                      label: const Text('Re Get Data'),
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
