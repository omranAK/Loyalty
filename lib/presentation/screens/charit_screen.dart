import '../../constant/imports.dart';

class CharityScreen extends StatefulWidget {
  const CharityScreen({super.key});

  @override
  State<CharityScreen> createState() => _CharityScreenState();
}

class _CharityScreenState extends State<CharityScreen> {
  late Bloc charityBloc;
  List<CharityModel> charities = [];
  List<CharityModel> filteredCharities = [];
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    charityBloc = BlocProvider.of<CharityBloc>(context);
    charityBloc.add(LoadCharityEvent());
    super.initState();
  }

  void _runFilter(String name) {
    List<CharityModel> resault = [];
    if (name.isEmpty) {
      resault = charities;
    } else {
      resault = charities
          .where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredCharities = resault;
    });
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
          localizations!.charity,
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
      body: SingleChildScrollView(
        child: BlocListener<CharityBloc, CharityState>(
          listener: (context, state) {
            if (state is CharityLoaddedState) {
              charities = state.charities;
              filteredCharities = charities;
            }
          },
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
                          icon: Icon(Icons.search,
                              color: Theme.of(context).primaryIconTheme.color),
                        ),
                        hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<CharityBloc, CharityState>(
                builder: (context, state) {
                  if (state is CharityLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).badgeTheme.backgroundColor,
                      ),
                    );
                  } else if (state is CharityFailedState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.restart_alt_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              charityBloc.add(
                                LoadCharityEvent(),
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
                    return CharityGrid(
                      charities: filteredCharities,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
