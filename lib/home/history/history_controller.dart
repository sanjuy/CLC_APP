import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/resources/user_detail.dart';

class HistoryController {
  static Future<List<AllCouponsList>> redeemedCoupons() async {
    Map<String, String> queryParams = {"p": "allcoupon"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    var dt = CouponListModelModel.fromJson(responce);
    List<AllCouponsList> lt1 = [];
    if (dt.data?.isNotEmpty ?? false) {
      List<AllCouponsList> lt = dt.data ?? [];
      for (var item in lt) {
        if (item.usageStatus == "Used") {
          lt1.add(item);
        }
      }
      return lt1;
    }
    return lt1;
  }
}
