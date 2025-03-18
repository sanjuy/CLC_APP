import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/authentication/otp/resend_otp_model.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class OtpController {
  static Future<void> resendOTP({
    required BuildContext context,
    required String email,
  }) async {
    Map<String, String> queryParams = {"p": "sendOtp"};
    Map<String, String> params = {};
    params["email"] = email;

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = ResendOtpModel.fromJson(responce);
    if (dt.data != null || dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    } else {
      showInSnackBar(context: context, message: responce["Message"].toString());
    }
    return;
  }

  static verifyOTP(
      {required BuildContext context,
      required String otp,
      required Function(bool) onVerified}) async {
    Map<String, String> queryParams = {"p": "verifyOtp"};
    Map<String, String> params = {};
    params["id"] = await UserDetail.getUserId ?? "";
    params["otp"] = otp;

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = responce["meta"] as Map<String, dynamic>;
    int code = dt["StatusCode"] as int;
    if (code == 200) {
      onVerified(true);
    }
    showInSnackBar(context: context, message: dt["Message"].toString());
  }
}
