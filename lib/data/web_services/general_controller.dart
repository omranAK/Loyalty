import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';

import '../models/response_model.dart';

class GeneralController {
  String returnCodeFunc(ResponseModel generalModel) {
    switch (generalModel.status) {
      case 401:
        return generalModel.message;
      case 403:
        return generalModel.message;
      case 400:
        return generalModel.message;
      case 500:
        return generalModel.message;
      case 404:
        return generalModel.message;
      default:
        return "success";
    }
  }

  showToast(String? toast) {
    Fluttertoast.showToast(
        msg: toast!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: AppColors.whiteMaterial,
        fontSize: 16.0);
  }
}
