// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../constant/imports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool active = false;
  bool passActive = false;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController emailController;
  late String phoneNumber;
  late Bloc profileBloc;
  void clearText() {
    newPasswordController.clear();
    passwordController.clear();
    confirmpassController.clear();
    phoneController.clear();
    nameController.clear();
    locationController.clear();
    descriptionController.clear();
    emailController.clear();
  }

  void update() {
    setState(() {
      clearText();
      active = !active;
      passActive = false;
    });
  }

  void update1() {
    setState(() {
      clearText();
      passActive = !passActive;
      active = false;
    });
  }

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(GetProfileDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final roleID = CacheManager.getUserModel()!.roleID;
    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      dialog(context, localizations!, passActive ? true : false);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        actions: [
          IconButton(
            onPressed: () {
              update1();
            },
            icon: Icon(
              Icons.key,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () => update(),
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) =>
            current is ProfileLoadingState ||
            current is ProfileInitial ||
            current is ProfileFaildState ||
            current is ProfileloaddedState,
        builder: (context, state) {
          if (state is ProfileloaddedState) {
            User user = state.user;
            nameController = TextEditingController(text: user.name);
            phoneController = TextEditingController(text: user.phone);
            phoneNumber = phoneController.text;
            locationController = TextEditingController(text: user.location);
            descriptionController = TextEditingController(text: user.about);
            emailController = TextEditingController(text: user.email);
            return Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.appBarColor,
                        AppColors.green,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          user.name.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 2.2),
                        child: Container(
                            color: Theme.of(context).colorScheme.background),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: height / 2.6,
                            left: width / 20,
                            right: width / 20,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 2.0,
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.all(width / 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      headerChild(
                                          localizations!.point, user.points),
                                      roleID == 4
                                          ? headerChild(
                                              localizations.spicialpoints,
                                              user.spicialPoins,
                                            )
                                          : const Center()
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height / 20),
                                child: SizedBox(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        infoChild(
                                          width,
                                          Icons.email,
                                          user.email,
                                          context,
                                          active,
                                          passActive,
                                          'email',
                                          emailController,
                                          localizations
                                        ),
                                        infoChild(
                                            width,
                                            Icons.call,
                                            user.phone,
                                            context,
                                            active,
                                            passActive,
                                            'phone',
                                            phoneController,localizations),
                                        active
                                            ? infoChild(
                                                width,
                                                Icons.person,
                                                user.name,
                                                context,
                                                active,
                                                passActive,
                                                'name',
                                                nameController,
                                                localizations
                                              )
                                            : const Center(),
                                        roleID == 5
                                            ? infoChild(
                                                width,
                                                Icons.location_on,
                                                user.location,
                                                context,
                                                active,
                                                passActive,
                                                'location',
                                                locationController,
                                                localizations
                                              )
                                            : const Center(),
                                        roleID == 5
                                            ? infoChild(
                                                width,
                                                Icons.description,
                                                user.about,
                                                context,
                                                active,
                                                passActive,
                                                'description',
                                                descriptionController,
                                                localizations
                                              )
                                            : const Center(),
                                        passActive
                                            ? infoChild(
                                                width,
                                                Icons.password,
                                                'Current password',
                                                context,
                                                active,
                                                passActive,
                                                'currentpassword',
                                                passwordController,
                                                localizations
                                              )
                                            : const Center(),
                                        passActive
                                            ? infoChild(
                                                width,
                                                Icons.key,
                                                'New Password',
                                                context,
                                                active,
                                                passActive,
                                                'newpassword',
                                                newPasswordController,
                                                localizations
                                              )
                                            : const Center(),
                                        passActive
                                            ? infoChild(
                                                width,
                                                Icons.check_outlined,
                                                'Confirm Password',
                                                context,
                                                active,
                                                passActive,
                                                'confirmpassword',
                                                confirmpassController,
                                                localizations
                                              )
                                            : const Center(),
                                        passActive || active
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  _submit();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.buttonColor),
                                                child: Text(
                                                  'submit',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (state is ProfileFaildState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations!.somthingwentwrong,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.restart_alt_outlined),
                    onPressed: () {
                      profileBloc.add(
                        GetProfileDataEvent(),
                      );
                    },
                    label: Text(localizations.regetdata),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).badgeTheme.backgroundColor,
              ),
            );
          }
        },
      ),
    );
  }

  Widget infoChild(
      double width,
      IconData icon,
      data,
      BuildContext context,
      bool active,
      bool passActive,
      String type,
      TextEditingController controller,
      AppLocalizations localizations
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: width / 10,
          ),
          Icon(
            icon,
            color: AppColors.pointCardColor,
            size: 36.0,
          ),
          SizedBox(
            width: width / 20,
          ),
          Expanded(
            child: TextFormField(
              autofocus: false,
              controller: controller,
              obscureText: type.contains('password') ? true : false,
              readOnly: type == 'phone' && active == false
                  ? true
                  : type == 'email'
                      ? true
                      : false,
              decoration: InputDecoration(
                  hintText: type.contains('password') ? data : null,
                  hintStyle: const TextStyle(fontWeight: FontWeight.w400),
                  border: type == 'phone' && passActive
                      ? InputBorder.none
                      : type == 'email'
                          ? InputBorder.none
                          : active || passActive
                              ? null
                              : InputBorder.none),
              style: TextStyle(
                color: Theme.of(context).primaryIconTheme.color,
              ),
              // ignore: body_might_complete_normally_nullable
              validator: (value) {
                if (type == 'newpassword') {
                  if (value!.isEmpty || value.length < 8) {
                    return localizations.passwordmustcontainatleast8characters;
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
                    return localizations.passwordmustcontainnumbers;
                  }
                } else if (type == 'confirmpassword') {
                  if (value!.isEmpty || value != newPasswordController.text) {
                    return localizations.passwordmustmatch;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialog(
      BuildContext context, AppLocalizations localizations, bool passChange) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Update information',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: !passChange
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Password:',
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
                        controller: passwordController,
                        obscureText: true,
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
              )
            : Text('Are you sure you want to change this information'),
        actions: [
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.darkGray),
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
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
            onPressed: () async {
              profileBloc.add(
                UpdateUserDataEvent(
                  phone: phoneNumber == phoneController.text
                      ? null
                      : phoneController.text,
                  newPassword: newPasswordController.text.isEmpty
                      ? null
                      : newPasswordController.text,
                  description: descriptionController.text.isEmpty
                      ? null
                      : descriptionController.text,
                  location: locationController.text.isEmpty
                      ? null
                      : locationController.text,
                  oldPassword: passwordController.text,
                  name:
                      nameController.text.isEmpty ? null : nameController.text,
                ),
              );
            },
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) =>
                  previous is ProfileUpdateLoadingState,
              listener: (context, state) {
                if (state is ProfileloaddedState) {
                  Navigator.of(context).pop();
                  active = false;
                  passActive = false;
                  passwordController.clear();
                  QuickAlert.show(
                      backgroundColor: Theme.of(context).cardColor,
                      context: context,
                      type: QuickAlertType.success,
                      titleColor: Theme.of(context).primaryIconTheme.color!,
                      title: 'Success',
                      confirmBtnColor: AppColors.buttonColor,
                      confirmBtnText: localizations.done);
                } else if (state is ProfileUpdateFailedState) {
                  Navigator.of(context).pop();
                  passwordController.clear();
                  QuickAlert.show(
                      backgroundColor: Theme.of(context).cardColor,
                      context: context,
                      type: QuickAlertType.error,
                      titleColor: Theme.of(context).primaryIconTheme.color!,
                      title: 'Failed',
                      text: state.errorMessage,
                      confirmBtnColor: AppColors.buttonColor,
                      confirmBtnText: localizations.done);
                }
              },
              buildWhen: (previous, current) =>
                  current is ProfileUpdateLoadingState,
              builder: (context, state) {
                if (state is ProfileUpdateLoadingState) {
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

Widget headerChild(String header, var value) => Expanded(
      child: Column(
        children: <Widget>[
          Text(
            header,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            '$value',
            style: GoogleFonts.montserrat(
                fontSize: 20,
                color: AppColors.green,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
