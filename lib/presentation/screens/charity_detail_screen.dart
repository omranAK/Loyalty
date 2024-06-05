import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/repository/charity_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/logic/charity/bloc/charity_bloc.dart';

class CharityDetailScreen extends StatelessWidget {
  final CharityModel charity;
  const CharityDetailScreen({
    super.key,
    required this.charity,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController ammountController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey();
    CharityRepository charityRepository =
        CharityRepository(externalService: ExternalService());
    Future _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      _formKey.currentState!.save();
      await charityRepository
          .donate({'points': ammountController.text, 'id': charity.id}, '');
    }

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
                  BlocBuilder<CharityBloc, CharityState>(
                    builder: (context, state) {
                      return Text(
                        'My Spicial Points',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                      );
                    },
                  ),
                  Text(
                    CacheManager.getSpicialPoint().toString(),
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
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
                'Bying Voucher',
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
                      height: 35,
                      child: TextFormField(
                        controller: ammountController,
                        keyboardType: TextInputType.emailAddress,
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
                      var response = await charityRepository.donate(
                        {
                          'points': ammountController.text,
                          'id': charity.id.toString(),
                        },
                        'donate_special_points',
                      );
                      if (response == 'success') {
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Done thank you for your generosity'),
                          ),
                        );
                      } else {
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(response),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Procced',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            ),
          );
        },
        label: const Text('Donate'),
        icon: const Icon(Icons.handshake),
      ),
      body: ListView(
        children: [
          // Product image
          Image.network(
            'http://10.0.2.2:8000/${charity.prof_img}',
            height: MediaQuery.of(context).size.height / 1.8,
            fit: BoxFit.fill,
          ),

          // Product title
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(
              charity.name.toUpperCase(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ),

          // Product description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(charity.description),
          ),

          // Product price

          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
