import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/server_config.dart';
import 'package:loyalty_system_mobile/logic/charity/bloc/charity_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quickalert/quickalert.dart';

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
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Text(
                    'My Spicial Points',
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
                'Donate',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Ammount:                         ',
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
                    'Cancel',
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
                    // var response = await charityRepository.donate(
                    //   {
                    //     'points': ammountController.text,
                    //     'id': charity.id.toString(),
                    //   },
                    //   'donate_special_points',
                    // );
                    // if (response == 'success') {
                    //   if (!context.mounted) return;
                    //   Navigator.pop(context);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       backgroundColor: Colors.green,
                    //       content: Text('Done thank you for your generosity'),
                    //     ),
                    //   );
                    // } else {
                    //   if (!context.mounted) return;
                    //   Navigator.pop(context);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(response),
                    //     ),
                    //   );
                    // }
                  },
                  child: BlocConsumer<CharityBloc, CharityState>(
                    listener: (context, state) {
                      if (state is DonateDoneState) {
                        ammountController.clear();
                        Navigator.of(context).pop();
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'Success',
                          confirmBtnColor: AppColors.buttonColor,
                        );
                      } else if (state is DonateFailedState) {
                        ammountController.clear();
                        Navigator.of(context).pop();
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Failed',
                          text: state.errorMessage,
                          confirmBtnColor: AppColors.buttonColor,
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is DonateLoadingState,
                    builder: (context, state) {
                      if (state is DonateLoadingState) {
                        return const CircularProgressIndicator();
                      } else {
                        return Text(
                          'Procced',
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
        label: const Text('Donate'),
        icon: const Icon(Icons.handshake),
      ),
      body: ListView(
        children: [
          // Charity image
          charity.prof_img != null
              ? CachedNetworkImage(
                  imageUrl:
                      '${ServerConfig.mainApiUrlImage}${charity.prof_img}',
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
