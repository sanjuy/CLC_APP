import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/profile/edit_profile_model.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class MembershipController {
  static changeMembershipType({
    required BuildContext context,
    required String membershipType,
  }) async {
    if (membershipType == "") {
      showInSnackBar(
          context: context, message: "Please Select Membership Type");
      return;
    }
    Map<String, String> queryParams = {"p": "editUser"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";
    params["membership_type"] = membershipType;

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    if (!context.mounted) return;
    var dt = EditProfileModel.fromJson(responce);
    if (dt.data != null && dt.meta != null) {
      UserDetail.setMembershipType = membershipType;
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
      Navigation.pop(context: context);
    } else if (dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    } else {
      showInSnackBar(context: context, message: responce["message"].toString());
    }
  }
}
