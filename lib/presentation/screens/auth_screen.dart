// ignore_for_file: body_might_complete_normally_nullable

import '../../constant/imports.dart';

enum FilterOption { arabic, english }

enum AuthMode { signup, login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
    'phone': '',
    'name': ''
  };
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final _passwordController = TextEditingController();
  late Bloc loginbloc;

  void cleartext() {
    emailController.clear();
    nameController.clear();
    phoneController.clear();
    confirmpassController.clear();
    _passwordController.clear();
  }

  @override
  void initState() {
    loginbloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'An Error Occurred!',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          message == 'You are not active'
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkGray,
                  ),
                  onPressed: () {
                    loginbloc.add(ResendOtpButtonPressedEvent());
                    Navigator.pushNamed(
                      context,
                      authOtp,
                      arguments: _authData['email'],
                    );
                  },
                  child: Text(
                    'Active now',
                    style: GoogleFonts.montserrat(color: Colors.white),
                  ),
                )
              : ElevatedButton(
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        loginbloc.add(LoginButtonPressedEvent(
            _authData['email']!, _authData['password']!));
      } else if (_authMode == AuthMode.signup) {
        // Sign user up
        loginbloc.add(
          SignUpButtonPressedEvent(_authData['name']!, _authData['email']!,
              _authData['password']!, _authData['phone']!),
        );
      } else {
        _showErrorDialog('You are Not Connected to the Internet');
        return;
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('Email or password incorrect!')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    double hieght = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.pushNamed(
              context,
              authOtp,
              arguments: _authData['email'],
            );
            cleartext();
          } else if (state is AuthFaildState) {
            loginbloc.add(AuthIntialEvent());
            _showErrorDialog(state.errorMessage.toString());
          } else if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, tabScreen);
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: width * 0.34,
                      height: hieght * 0.22,
                      child: Image(
                        color: Theme.of(context).badgeTheme.backgroundColor,
                        fit: BoxFit.contain,
                        image: const AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: _field(
                        localizations!,
                        emailController,
                        TextInputType.emailAddress,
                        Icons.email_outlined,
                        'email',
                        'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_authMode == AuthMode.signup)
                      SizedBox(
                        width: width * 0.8,
                        child: _field(localizations, nameController,
                            TextInputType.name, Icons.person, 'name', 'Name'),
                      ),
                    if (_authMode == AuthMode.signup)
                      const SizedBox(
                        height: 20,
                      ),
                    if (_authMode == AuthMode.signup)
                      SizedBox(
                        width: width * 0.8,
                        child: _field(
                            localizations,
                            phoneController,
                            TextInputType.phone,
                            Icons.phone,
                            'phone',
                            'Phone Number'),
                      ),
                    if (_authMode == AuthMode.signup)
                      const SizedBox(
                        height: 20,
                      ),
                    SizedBox(
                      width: width * 0.8,
                      child: _field(
                          localizations,
                          _passwordController,
                          TextInputType.visiblePassword,
                          Icons.key,
                          'password',
                          'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_authMode == AuthMode.signup)
                      SizedBox(
                        width: width * 0.8,
                        child: _field(
                            localizations,
                            confirmpassController,
                            TextInputType.visiblePassword,
                            Icons.check_outlined,
                            'confirm',
                            'Confirm Password'),
                      ),
                    if (_authMode == AuthMode.signup)
                      const SizedBox(
                        height: 25,
                      ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return const CircularProgressIndicator();
                        } else {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              fixedSize: const Size(184, 41),
                            ),
                            onPressed: _submit,
                            child: Text(
                              _authMode == AuthMode.signup
                                  ? localizations.signip
                                  : localizations.login,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        _switchAuthMode();
                        cleartext();
                      },
                      child: Text(
                        _authMode == AuthMode.signup
                            ? localizations.alreadyhaveaccount
                            : localizations.donthaveaccountyet,
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _field(
      AppLocalizations localizations,
      TextEditingController controller,
      TextInputType textInputType,
      IconData icon,
      String x,
      String hintText) {
    return TextFormField(
      onFieldSubmitted: x == 'password' && _authMode == AuthMode.login
          ? (value) => _submit()
          : null,
      obscureText: x == 'password' || x == 'confirm' ? true : false,
      controller: controller,
      keyboardType: textInputType,
      inputFormatters: [
        if (x == 'phone') LengthLimitingTextInputFormatter(10),
        if (x == 'phone') FilteringTextInputFormatter.digitsOnly
      ],
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.sIcon,
          ),
          hintText: hintText),
      validator: (value) {
        if (_authMode == AuthMode.signup) {
          if (x == 'email') {
            if (value!.isEmpty || !value.contains('@')) {
              return localizations.invalidemail;
            }
          } else if (x == 'name') {
            if (value!.isEmpty) {
              return localizations.invalidname;
            }
          } else if (x == 'phone') {
            if (value!.isEmpty || value.length < 10 && value.length > 10) {
              return localizations.invalidphone;
            }
          } else if (x == 'password') {
            if (value!.isEmpty || value.length < 8) {
              return 'Password must contain at least 8 characters';
            }
            if (!value.contains('1') &
                !value.contains('2') &
                !value.contains('3') &
                !value.contains('4') &
                !value.contains('5') &
                !value.contains('6') &
                !value.contains('7') &
                !value.contains('8') &
                !value.contains('9') &
                !value.contains('0')) {
              return "Password must contain numbers like (1 2 3 ..)";
            }
          } else if (x == 'confirm') {
            if (value!.isEmpty || value != _passwordController.text) {
              return 'Password must match';
            }
          }
        } else if (_authMode == AuthMode.login) {
          if (x == 'password') {
            if (value!.isEmpty || value.length < 8) {
              return 'Password must contain at least 8 characters';
            }
          }
        }
      },
      onSaved: (newValue) {
        if (x != 'confirm') {
          _authData[x] = newValue!;
        }
      },
    );
  }
}
