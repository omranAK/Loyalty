import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:loyalty_system_mobile/constant/constant_data.dart';
import 'package:loyalty_system_mobile/logic/auth/bloc/auth_bloc.dart';

class AuthOtp extends StatefulWidget {
  final String? data;

  const AuthOtp({super.key, this.data});

  @override
  State<AuthOtp> createState() => _AuthOtpState();
}

class _AuthOtpState extends State<AuthOtp> {
  late Bloc otpBloc;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController thre = TextEditingController();
  TextEditingController four = TextEditingController();

  List<String> otpList = [];
  Timer? _timer;
  late int _start;
  @override
  void initState() {
    otpBloc = BlocProvider.of<AuthBloc>(context);
    startTimer();
    super.initState();
  }

  void cleartext() {
    one.clear();
    two.clear();
    thre.clear();
    four.clear();
  }

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
              cleartext();
            },
          )
        ],
      ),
    );
  }

  void startTimer() {
    _start = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      String otp = otpList.join('');

      otpBloc.add(
        ConfirmOtpButtonPressedEvent(otp: otp),
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        otpBloc.add(AuthIntialEvent());
      },
      child: Scaffold(
        backgroundColor: AppColors.appBarColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpLoadingState) {
            } else if (state is OtpFaildState) {
              _showErrorDialog("Wrong OTP Entered");
            } else if (state is OtpSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, tabScreen, (Route<dynamic> route) => false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verefication code',
                  style:
                      GoogleFonts.montserrat(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'We have sent the code verefication to ',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white54,
                      fontWeight: FontWeight.w300),
                ),
                Row(
                  children: [
                    Text(
                      widget.data!,
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthIntialEvent());
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'change the email?',
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        otpCell(context, otpList, one),
                        otpCell(context, otpList, two),
                        otpCell(context, otpList, thre),
                        otpCell(context, otpList, four),
                      ],
                    ))
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is OtpLoadingState) {
                return const CircularProgressIndicator();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _start == 0
                        ? () {
                            startTimer();
                            otpList.clear();
                            otpBloc.add(ResendOtpButtonPressedEvent());
                            setState(() {
                              cleartext();
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.sizeOf(context).width * 0.4, 30),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.darkGray),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.appBarColor),
                    child: Text(
                      _start == 0 ? 'Resend' : '0:$_start',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGray,
                      fixedSize:
                          Size(MediaQuery.sizeOf(context).width * 0.4, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: Colors.white),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Container otpCell(BuildContext context, List<String> otp,
      TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: 60,
      height: 55,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'invalid otp';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
            otp.add(value);
          }
        },
        cursorColor: AppColors.pointCardColor,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }
}
