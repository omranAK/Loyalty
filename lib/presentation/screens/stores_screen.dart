import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/store_model.dart';
import 'package:loyalty_system_mobile/logic/stores/bloc/stores_bloc.dart';
import 'package:loyalty_system_mobile/presentation/widgets/store_item.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late Bloc storesBloc;
  List<StoreModel> storeList = [];
  @override
  void initState() {
    storesBloc = BlocProvider.of<StoresBloc>(context);
    storesBloc.add(LoadStoresEvent());
    super.initState();
  }

  Future<void> reGet() async {
    storesBloc.add(LoadStoresEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Stores',
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
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.73,
                child: RefreshIndicator(
                  onRefresh: () {
                    return reGet();
                  },
                  child: BlocBuilder<StoresBloc, StoresState>(
                    builder: (context, state) {
                      if (state is StoresLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is StoresFailedState) {
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
                                    storesBloc.add(
                                      LoadStoresEvent(),
                                    );
                                  },
                                  label: const Text('data'))
                            ],
                          ),
                        );
                      } else {
                        return storeList.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.all(8),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: storeList.length,
                                itemBuilder: ((ctx, i) =>  StoreItem(store: storeList[i],)),
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
