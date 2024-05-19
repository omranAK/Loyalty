import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/logic/transfer/bloc/transfer_bloc.dart';

class TransferScreen extends StatelessWidget {
  static const route = '/transfer';
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: Image.asset('assets/images/transfer.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'My Points',
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
                        width: 150,
                        height: 75,
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
                            const Text(
                              'points',
                              style: TextStyle(
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
                      'Recever email:',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 35,
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
                      'Ammount:                         ',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
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
                      'Re Enter the Ammount:',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 35,
                      child: TextFormField(
                        controller: confirmAmmountController,
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Transfer done'),
                        ),
                      );
                    } else if (state is TransferFaildState) {
                      _showErrorDialog(state.errorMessage);
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
                          minimumSize: const Size(250, 50),
                          backgroundColor: AppColors.darkGray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Proceed',
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
