import 'package:loyalty_system_mobile/constant/constant_data.dart';
import 'package:dio/dio.dart';

class AuthWebServices {
  late Dio dio;
  AuthWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: basUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }
  Future<dynamic> getUser() async {
    Response response = await dio.get('');
    return response.data;
  }

  Future<dynamic> login(String email, String password) async {
    Response response = await dio.post('');
    return response.statusCode;
  }

  Future<dynamic> signup(
      String name, String email, String password, String phonenumber) async {
    Response response = await dio.post('');
    return response.statusCode;
  }
}
