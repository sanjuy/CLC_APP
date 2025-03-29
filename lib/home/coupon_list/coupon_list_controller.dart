import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/resources/user_detail.dart';

class CouponListController {
  static Future<List<AllCouponsList>> couponsList() async {
    Map<String, String> queryParams = {"p": "allcoupon"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    // if (!context.mounted) return;
    List<AllCouponsList> lt1 = [];
    var dt = CouponListModelModel.fromJson(responce);
    if (dt.data?.isNotEmpty ?? false) {
      List<AllCouponsList> lt = dt.data ?? [];
      for (var item in lt) {
        if (item.usageStatus == "Unused") {
          lt1.add(item);
        }
      }
      return lt1;
    }
    return lt1;
    // else {
    //   showInSnackBar(context: context, message: responce["message"].toString());
    // }
  }
}
