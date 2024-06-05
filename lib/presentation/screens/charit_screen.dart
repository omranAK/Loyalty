import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/logic/charity/bloc/charity_bloc.dart';
import 'package:loyalty_system_mobile/presentation/widgets/charity_grid.dart';

class CharityScreen extends StatefulWidget {
  const CharityScreen({super.key});

  @override
  State<CharityScreen> createState() => _CharityScreenState();
}

class _CharityScreenState extends State<CharityScreen> {
  late Bloc charityBloc;
  List<CharityModel> charities = [];
  @override
  void initState() {
    charityBloc = BlocProvider.of<CharityBloc>(context);
    charityBloc.add(LoadCharityEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Charity',
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
      body: BlocListener<CharityBloc, CharityState>(
        listener: (context, state) {
          if (state is CharityLoaddedState) {
            charities = state.charities;
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
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.60,
                  height: MediaQuery.sizeOf(context).height * 0.041,
                  child: TextFormField(
                    // controller: textEditingController,
                    // onFieldSubmitted: (newValue) {
                    //   value = newValue;
                    //   final List<Store> searchresult =
                    //       Provider.of<Stores>(context, listen: false)
                    //           .findByName(newValue);
                    //   Navigator.of(context).pushNamed(
                    //     '/search_store',
                    //     arguments: {
                    //       'list': searchresult,
                    //       'value': newValue,
                    //     },
                    //   );
                    //   clearText();
                    // },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(7),
                      hintTextDirection: TextDirection.ltr,
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                        onPressed: () {},
                        padding: const EdgeInsets.all(-15),
                        // onPressed: () {
                        //   final List<Store> searchresult =
                        //       Provider.of<Stores>(context, listen: false)
                        //           .findByName(value!);
                        //   Navigator.of(context).pushNamed(
                        //     '/search_store',
                        //     arguments: {
                        //       'list': searchresult,
                        //       'value': value,
                        //     },
                        //   );
                        //   clearText();
                        // },
                        icon: const Icon(Icons.search, color: Colors.black),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CharityFailedState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Somthing Went Wrong!!!! Try again Please',
                          style: GoogleFonts.montserrat(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.dangerous),
                          onPressed: () {
                            charityBloc.add(
                              LoadCharityEvent(),
                            );
                          },
                          label: const Text('data'),
                        )
                      ],
                    ),
                  );
                } else {
                  return CharityGrid(
                    charities: charities,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
