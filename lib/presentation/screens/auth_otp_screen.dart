import '../../constant/imports.dart';

class AuthOtp extends StatefulWidget {
  final String? data;

  const AuthOtp({super.key, this.data});

  @override
  State<AuthOtp> createState() => _AuthOtpState();
}

class _AuthOtpState extends State<AuthOtp> {
  late String email;
  late Bloc otpBloc;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController thre = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
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

  void _showErrorDialog(String header, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          header,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkGray,
            ),
            child: Text(
              header == 'Warning!' ? 'Leave' : 'Okay',
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              header == 'Warning!' ? Navigator.of(context).pop() : null;
              header == 'Warning!'
                  ? CacheManager.clearSharedPreferences()
                  : null;
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
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.appBarColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              _showErrorDialog('Warning!',
                  'when you leave you can\'t use your phone number with another email');
            },
          ),
          backgroundColor: AppColors.appBarColor,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is OtpFaildState) {
              _showErrorDialog('An Error Accured!', "Wrong OTP Entered");
            } else if (state is OtpSuccessState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                tabScreen,
                (route) => false,
              );
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Text(
                          email,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
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
                  ),
                ),
                TextButton(
                    onPressed: () {
                      dialog(context, localizations!);
                    },
                    child: Text(
                      'change the email?',
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
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
  Future<dynamic> dialog(BuildContext context, AppLocalizations localizations) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Update Email',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: TextFormField(
          controller: newEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(top: 0, bottom: 10, left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.darkGray),
            onPressed: () {
              newEmailController.clear();
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
            onPressed: () async {
              otpBloc.add(ChangeEmailEvent(newEmail: newEmailController.text));
            },
            child: BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  previous is ChangeEmailLoadingState,
              listener: (context, state) {
                if (state is ChangeEmailSuccessState) {
                  startTimer();
                  email = newEmailController.text;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text('We sent email verification to the new email'),
                    ),
                  );

                  newEmailController.clear();
                } else if (state is ChangeEmailFaildState) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Sorry somthing went wrong please try again!'),
                    ),
                  );
                }
              },
              buildWhen: (previous, current) =>
                  current is ChangeEmailLoadingState,
              builder: (context, state) {
                if (state is ChangeEmailLoadingState) {
                  return CircularProgressIndicator(
                    color: Theme.of(context).badgeTheme.backgroundColor,
                  );
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
  }
}

