import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/home/history/history_model.dart';
import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/resources/extenssions.dart';
import 'package:clc_app/resources/user_detail.dart';

class HistoryController {
  static Future<List<Reward>> redeemedCoupons() async {
    Map<String, String> queryParams = {"p": "allRedeems"};
    Map<String, String> params = {};
    params["user_id"] = await UserDetail.getUserId ?? "";

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    var dt = CouponHistoryModel.fromJson(responce);
    List<Reward> rewards = [];
    if (dt.data?.isNotEmpty ?? false) {
      List<CouponHistory> lt = dt.data ?? [];
      for (var item in lt) {
        rewards.add(
          Reward(
            imageUrl: 'logo.png'.directory(),
            title: item.title.toString(),
            description: item.description.toString(),
            couponType: item.couponType.toString(),
            isPaid: false,
          ),
        );
      }

      return rewards;
    }
    return rewards;
  }
}
