import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/home/redeem/redeem_model.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class RedeemController {
  static redeemNow(
      {required BuildContext context, required String couponID}) async {
    Map<String, String> queryParams = {"p": "addRedeem"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";
    params["coupon_id"] = couponID;

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = RedeemModel.fromJson(responce);
    if (dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    }
    Navigation.pop(context: context);
  }
}
