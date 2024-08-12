import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import '../models/response_model.dart';

class GeneralController {
  String returnCodeFunc(ResponseModel generalModel) {
    switch (generalModel.status) {
      case 200:
        return 'success';
      default:
        String message1 = generalModel.message.replaceAll('"message":', '');
       String message= message1.replaceAll('"status":${generalModel.status},', '');
        return message;
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
