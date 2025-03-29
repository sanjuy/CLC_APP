import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class RedeemController {
  static redeemNow({
    required BuildContext context,
    required String couponID,
    required Function() onRedeem,
  }) async {
    Map<String, String> queryParams = {"p": "addRedeem"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";
    params["coupon_id"] = couponID;

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = responce["meta"] as Map<String, dynamic>;
    int code = dt["StatusCode"] as int;
    if (code == 200 || code == 201) {
      showInSnackBar(context: context, message: dt["Message"].toString());
    } else {
      showInSnackBar(context: context, message: dt["Message"].toString());
    }
    onRedeem();
    Navigation.pop(context: context);
  }
}
