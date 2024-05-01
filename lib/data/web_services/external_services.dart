import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/response_model.dart';
import '../storage/cache_manager.dart';
import 'server_config.dart';

class ExternalService {
  String? token = CacheManager.getToken();
  String? lang = CacheManager.getLang();
  Map<String, String> headerMap = {};
  var uri = Uri();

  ExternalService() {
    // if (CacheManager.getToken() == null) {
    //   headerMap = {
    //     // HttpHeaders.contentTypeHeader: 'application/json',
    //     // "lang": CacheManager.getLang() ?? "ar",
    //   };
    // } else {
    headerMap = {
      "Authorization": 'Bearer${token}',
      //HttpHeaders.contentTypeHeader: 'application/json',
      // "lang": CacheManager.getLang() ?? "ar",
    };
    //}
  }

  get responseJson => null;

  // get data from server with parameters
  Future<ResponseModel> getData(var queryParameters, String urlService) async {
    uri = Uri.parse(ServerConfig.mainApiUrl + urlService);

    if (queryParameters != null) {
      uri = uri.replace(
        queryParameters: queryParameters,
      );
    }
    headerMap = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheManager.getToken()}',
    };
    try {
      var response = await http.get(uri, headers: headerMap);

      if (response.statusCode != 500) {
        dynamic data = jsonDecode(response.body);
        return ResponseModel.fromJson(data);
      } else {
        return ResponseModel(status: 500, message: 'Server error');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout Error: $e');
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Error: $e');
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print('General Error: $e');
      }
    }
    return ResponseModel(status: 500, message: 'Server error');
  }

  Future<ResponseModel> postDataMap(body, String urlService) async {
    uri = Uri.parse(ServerConfig.mainApiUrl + urlService);

    try {
      var response = await http
          .post(uri, body: body, headers: {'Accept': 'application/json'});

      if (response.statusCode != 500) {
        dynamic data = jsonDecode(response.body);

        if (response.statusCode == 200) {}
        return ResponseModel.fromJson(data);
      } else {
        return ResponseModel(status: 500, message: 'something wrong');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout Error: $e');
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Error: $e');
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print('General Error: $e');
      }
    }
    return ResponseModel(status: 500, message: 'Something Wrong');
  }

  ////////////////////////////////////////////////////////////////////////////////////////
  Future<ResponseModel> postDataMap1(body, String urlService) async {
    uri = Uri.parse(ServerConfig.mainApiUrl + urlService);

    try {
      var response = await http.post(uri, body: body, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheManager.getToken()}'
      });
      if (response.statusCode != 500) {
        dynamic data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print("tooooooooooooooooooken" + "${CacheManager.getToken()}");
        }
        return ResponseModel.fromJson(data);
      } else {
        return ResponseModel(status: 500, message: 'something wrong');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout Error: $e');
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Error: $e');
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print('General Error: $e');
      }
    }
    print("tooooooooooooooooooken" + "${CacheManager.getToken()}");
    return ResponseModel(status: 500, message: 'Something Wrong');
  }

  //////////////////////////////////////////////////////////////////////////////////
  Future<ResponseModel> postData(Map body, String endPoint) async {
    // print(body);
    uri = Uri.parse(ServerConfig.mainApiUrl + endPoint);

    try {
      var response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${CacheManager.getToken()}'
        }, // headers: {"lang": "ar"},
        body: body,
      );

      var result = jsonDecode(response.body);
      print(result);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 404) {
        if (CacheManager.getToken() == null || CacheManager.getToken() == "") {
          token = response.headers["authorization"];
          CacheManager.setToken(token!);
        }
        return ResponseModel.fromJson(result);
      } else {
        return ResponseModel(status: 500, message: 'something wrong');
      }
    } on TimeoutException {
      return ResponseModel(status: 500, message: 'something wrong');
    }
    //  on SocketException {
    //   return ResponseModel(status: "Socket", message: [], returnedCode: 500);
    // }
  }

  // TODO try{}catch{}
  // post data to server as form data without application/json header
  Future<ResponseModel> postFormData(
      Map<String, dynamic> body, String urlService) async {
    uri = Uri.parse(ServerConfig.mainApiUrl + urlService);

    var response = await http.post(
      uri,
      //  headers: headerMap = {"Authorization": '$token'},
      body: body,
    );

    if (response.statusCode != 500) {
      // if (response != null) {
      dynamic data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (token == null || token == "") {
          token = response.headers['authorization'];
          CacheManager.setToken(token!);
          ExternalService();
        }
      }
      return ResponseModel.fromJson(data);
    } else {
      return ResponseModel(status: 500, message: 'Server error');
      // return ResponseModel(error:"Request Time Out");
    }
  }

  Future<ResponseModel> postDataWithoutAuth(
      Map<String, dynamic> body, String urlService) async {
    uri = Uri.parse(ServerConfig.mainApiUrl + urlService);

    try {
      var response = await http.post(
        uri,
        headers: headerMap,
        body: jsonEncode(body),
      );

      if (response.statusCode != 500) {
        dynamic data = jsonDecode(response.body);
        return ResponseModel.fromJson(data);
      } else {
        return ResponseModel(status: 500, message: 'Server error');
      }
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Timeout Error: $e');
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Socket Error: $e');
      }
    } on Error catch (e) {
      if (kDebugMode) {
        print('General Error: $e');
      }
    }
    return ResponseModel(status: 500, message: 'Server error');
  }
}
