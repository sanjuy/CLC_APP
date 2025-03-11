import 'package:clc_app/apis_services/apis_services.dart';
import 'package:clc_app/home/coupon_list/coupon_list_model.dart';
import 'package:clc_app/home/reward_card_view.dart';
import 'package:clc_app/resources/extenssions.dart';

class CouponListController {
  static Future<List<Reward>> couponsList() async {
    Map<String, String> queryParams = {"p": "allcoupon"};
    Map<String, String> params = {};

    var responce = await ApiService.postRequest(
      params: params,
      queryParams: queryParams,
    );
    // if (!context.mounted) return;
    var dt = CouponListModelModel.fromJson(responce);
    List<Reward> rewards = [];
    if (dt.meta?.data?.isNotEmpty ?? false) {
      List<AllCouponsList> lt = dt.meta?.data ?? [];
      for (var item in lt) {
        rewards.add(
          Reward(
            imageUrl: 'logo.png'.directory(),
            title: item.title.toString(),
            description: item.description.toString(),
            isPaid: item.membershipType != "ChowLucky - Free",
          ),
        );
      }

      return rewards;
    }
    return rewards;
    // else {
    //   showInSnackBar(context: context, message: responce["message"].toString());
    // }
  }
}
