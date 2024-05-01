import 'dart:async';

import 'package:loyalty_system_mobile/data/models/user_model.dart';

import '../web_services/auth_services.dart';

class AuthRepository {
  final AuthWebServices authWebServices;

  AuthRepository({required this.authWebServices});
  Future login(String email, String password) async {
    final user = await authWebServices.login(
      email,
      password,
    );
    return User.fromJason(user);
  }

  Future signup(
      String name, String email, String password, String phonenumber) async {
    final user = await authWebServices.signup(
      name,
      email,
      password,
      phonenumber,
    );
    return User.fromJason(user);
  }

  Future getUser() async {
    final user = await authWebServices.getUser();
    return User.fromJason(user);
  }
}
