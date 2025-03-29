import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/authentication/forgot/send_otp_model.dart';
import 'package:clc_app/authentication/login/login_screen.dart';
import 'package:clc_app/authentication/otp/otp_screen.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class ForgotController {
  static sendOTO({required BuildContext context, required String email}) async {
    if (email == "") {
      showInSnackBar(
          context: context, message: "Please Enter Correct Email Address");
      return;
    }
    Map<String, String> queryParams = {"p": "sendOtp"};
    Map<String, String> params = {};
    params["email"] = email;
    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = SendOtpModel.fromJson(responce);
    if (dt.data != null && dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
      UserDetail.setUserId = dt.data?.id ?? "";
      _moveTo(context, email);
    } else if (dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    } else {
      showInSnackBar(context: context, message: responce["Message"].toString());
    }
  }

  static _moveTo(BuildContext context, String email) {
    Navigation.push(
        context: context,
        moveTo: OtpScreen(emailId: email, verificationType: "forgotPassword"));
  }

  static createNewPassword(
      {required BuildContext context, required String password}) async {
    if (password == "") {
      showInSnackBar(context: context, message: "Please Enter New Password");
      return;
    }
    Map<String, String> queryParams = {"p": "changePassword"};
    Map<String, String> params = {};
    params["id"] = await UserDetail.getUserId ?? "";
    params["newpassword"] = password;
    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = responce["meta"] as Map<String, dynamic>;
    int code = dt["StatusCode"] as int;
    if (code == 200) {
      Navigation.pushAndRemoveUntil(context: context, moveTo: LoginScreen());
    }
    showInSnackBar(context: context, message: dt["Message"].toString());
  }
}
//changePassword
