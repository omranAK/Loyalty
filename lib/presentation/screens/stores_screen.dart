import '../../constant/imports.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late Bloc storesBloc;
  TextEditingController textEditingController = TextEditingController();
  List<StoreModel> storeList = [];
  List<StoreModel> filteredStores = [];
  @override
  void initState() {
    storesBloc = BlocProvider.of<StoresBloc>(context);
    storesBloc.add(LoadStoresEvent());
    super.initState();
  }

  void _runFilter(String name) {
    List<StoreModel> resault = [];
    if (name.isEmpty) {
      resault = storeList;
    } else {
      resault = storeList
          .where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredStores = resault;
    });
  }

  Future<void> reGet() async {
    storesBloc.add(LoadStoresEvent());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          localizations!.stores,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: BlocListener<StoresBloc, StoresState>(
        listener: (context, state) {
          if (state is StoresLoaddedState) {
            storeList = state.storeModel;
            filteredStores = state.storeModel;
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: width * 0.60,
                    height: height * 0.041,
                    child: TextFormField(
                      controller: textEditingController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          padding: const EdgeInsets.all(-15),
                          icon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryIconTheme.color,
                          ),
                        ),
                        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.73,
                child: RefreshIndicator(
                  onRefresh: () {
                    return reGet();
                  },
                  child: BlocBuilder<StoresBloc, StoresState>(
                    builder: (context, state) {
                      if (state is StoresLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).badgeTheme.backgroundColor,
                          ),
                        );
                      } else if (state is StoresFailedState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                localizations.somthingwentwrong,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  storesBloc.add(
                                    LoadStoresEvent(),
                                  );
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
                        return filteredStores.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.all(8),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: filteredStores.length,
                                itemBuilder: ((ctx, i) => StoreItem(
                                      store: filteredStores[i],
                                    )),
                              )
                            : const Center(
                                child: Text('NO Store to show!!!'),
                              );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
