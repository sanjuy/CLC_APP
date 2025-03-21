import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/home/ads/ads_model.dart';
import 'package:clc_app/resources/user_detail.dart';

class AdsController {
  static getAds(Function() onCompletion) async {
    Map<String, String> queryParams = {"p": "allads"};
    Map<String, String> params = {};

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
      isShowLoader: false,
    );
    var dt = AdsModel.fromJson(responce);
    if (dt.data?.isNotEmpty ?? false) {
      for (var item in dt.data ?? []) {
        if (item.name == "Dashboard") {
          UserDetail.setFullAd = item.images ?? "";
          UserDetail.setFullAdUrl = item.adsurl ?? "";
        }
        if (item.name == "couponlist") {
          UserDetail.setListAd = item.images ?? "";
          UserDetail.setListAdUrl = item.adsurl ?? "";
        }
        if (item.name == "Coupon Popup") {
          UserDetail.setPopupAd = item.images ?? "";
          UserDetail.setPopupAdUrl = item.adsurl ?? "";
        }
      }
      onCompletion();
    }
  }
}
