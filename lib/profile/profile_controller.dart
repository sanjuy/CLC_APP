import 'dart:io';

import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/profile/edit_profile_model.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/user_detail.dart';
import 'package:flutter/material.dart';

class ProfileController {
  static editProfile({
    required BuildContext context,
    required String name,
    required String mobile,
    required String address,
    File? file,
  }) async {
    if (name == "") {
      showInSnackBar(context: context, message: "Please Enter Name");
      return;
    }
    if (mobile == "") {
      showInSnackBar(context: context, message: "Please Enter Contact No.");
      return;
    }
    if (address == "") {
      showInSnackBar(context: context, message: "Please Enter Address");
      return;
    }
    Map<String, String> queryParams = {"p": "editUser"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";
    params["name"] = name;
    params["contact_no"] = mobile;
    params["address"] = address;
    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
      filePath: file,
    );
    if (!context.mounted) return;
    var dt = EditProfileModel.fromJson(responce);
    if (dt.data != null && dt.meta != null) {
      UserDetail.setUserName = dt.data?.name ?? "";
      UserDetail.setMobileNUmber = dt.data?.contactNo ?? "";
      UserDetail.setProfilePicture = dt.data?.profilePicture ?? "";
      UserDetail.setAddress = dt.data?.address ?? "";
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
      Navigation.pop(context: context);
    } else if (dt.meta != null) {
      showInSnackBar(context: context, message: dt.meta?.message ?? "");
    } else {
      showInSnackBar(context: context, message: responce["message"].toString());
    }
  }
}
