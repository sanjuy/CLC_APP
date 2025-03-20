import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class ResetPassControllert {
  static resetPassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (currentPassword == "") {
      showInSnackBar(
          context: context, message: "Please Enter Current Password");
      return;
    }
    if (newPassword == "") {
      showInSnackBar(context: context, message: "Please Enter New Password");
      return;
    }
    if (confirmPassword == "") {
      showInSnackBar(
          context: context, message: "Please Enter Confirm Password");
      return;
    }
    if (confirmPassword != newPassword) {
      showInSnackBar(
          context: context,
          message: "New Password and Confirm Password did not Match");
      return;
    }
    Map<String, String> queryParams = {"p": "userPasswordChanged"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";
    params["new_password"] = newPassword;
    params["confirm_password"] = confirmPassword;
    params["current_password"] = currentPassword;

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = responce["meta"] as Map<String, dynamic>;
    var st = dt["StatusCode"] as int;
    if (st == 200) {
      showInSnackBar(context: context, message: dt["Message"].toString());
      Navigation.pop(context: context);
    }
  }
}
