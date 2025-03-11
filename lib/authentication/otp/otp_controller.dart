import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/authentication/otp/resend_otp_model.dart';
import 'package:clc_app/resources/alert_view.dart';
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
      showInSnackBar(context: context, message: responce["message"].toString());
    }
    return;
  }
}
