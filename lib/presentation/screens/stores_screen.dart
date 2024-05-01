import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/presentation/widgets/stores_list.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
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
                    hintText: 'Search.....',
                    hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.73,
              child: StoresList()),
        ],
      ),
    );
  }
}
