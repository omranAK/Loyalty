import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/logic/transfer/bloc/transfer_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TransferScreen extends StatelessWidget {
  static const route = '/transfer';
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController ammountController = TextEditingController();
    final TextEditingController confirmAmmountController =
        TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey();

    final Map<String, dynamic> _tranferData = {
      'email': '',
      'ammount': 0.0,
    };
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.appBarColor,
          title: Text(
            'An Error Occurred!',
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
          content: Text(
            message,
            style: GoogleFonts.montserrat(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGray,
              ),
              child: Text(
                'Okay',
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    void clearText() {
      confirmAmmountController.clear();
      emailController.clear();
      ammountController.clear();
    }

    Future _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      _formKey.currentState!.save();
      BlocProvider.of<TransferBloc>(context).add(ProccedButtonPressedEvent(
          email: emailController.text,
          ammount: double.tryParse(ammountController.text)!));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Transfer Points',
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.3,
                child: Image.asset(
                  'assets/images/transfer.png',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    localizations!.points,
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  BlocBuilder<TransferBloc, TransferState>(
                    builder: (context, state) {
                      return Container(
                        margin: const EdgeInsets.only(right: 35, top: 35),
                        width: width * 0.36,
                        height: height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.pointCardColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${CacheManager.getPoint()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              localizations.point,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      localizations.reciveremail,
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: width * 0.6,
                      height: height * 0.04,
                      margin: const EdgeInsets.all(8),
                      child: TextFormField(
                        onSaved: (newValue) =>
                            _tranferData['email'] = newValue!,
                        cursorHeight: 5,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          isDense: true,
                          fillColor: AppColors.lightGray,
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(top: 0, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'invalidemail';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${localizations.ammount}                         ',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.36,
                      height: height * 0.04,
                      child: TextFormField(
                          controller: ammountController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(top: 0, bottom: 10, left: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          onSaved: (newValue) {
                            _tranferData['ammount'] =
                                double.tryParse(newValue!);
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      localizations.reenterammount,
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.36,
                      height: height * 0.04,
                      child: TextFormField(
                        controller: confirmAmmountController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(top: 0, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value != ammountController.text) {
                            return 'No Match';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<TransferBloc, TransferState>(
                  listener: (context, state) {
                    if (state is TransferSuccessState) {
                      clearText();
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Success',
                        confirmBtnColor: AppColors.buttonColor,
                      );
                    } else if (state is TransferFaildState) {
                      
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Failed',
                        text: state.errorMessage,
                        confirmBtnColor: AppColors.buttonColor,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is TransferLoadiingState) {
                      return const CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          _submit();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(width * 0.6, height * 0.06),
                          backgroundColor: AppColors.darkGray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          localizations.procced,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
