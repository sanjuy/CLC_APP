class CouponHistoryModel {
  Meta? meta;
  List<CouponHistory>? data;

  CouponHistoryModel({
    this.meta,
    this.data,
  });

  factory CouponHistoryModel.fromJson(Map<String, dynamic> json) =>
      CouponHistoryModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<CouponHistory>.from(
                json["data"]!.map((x) => CouponHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CouponHistory {
  String? redeemId;
  String? userId;
  String? userName;
  String? email;
  String? couponId;
  String? title;
  String? restaurantId;
  String? description;
  String? couponType;
  String? discountType;
  String? discountValue;
  String? couponStatus;
  String? redeemType;
  String? usageStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  CouponHistory({
    this.redeemId,
    this.userId,
    this.userName,
    this.email,
    this.couponId,
    this.title,
    this.restaurantId,
    this.description,
    this.couponType,
    this.discountType,
    this.discountValue,
    this.couponStatus,
    this.redeemType,
    this.usageStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory CouponHistory.fromJson(Map<String, dynamic> json) => CouponHistory(
        redeemId: json["redeem_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        email: json["email"],
        couponId: json["coupon_id"],
        title: json["title"],
        restaurantId: json["restaurant_id"],
        description: json["description"],
        couponType: json["coupon_type"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        couponStatus: json["coupon_status"],
        redeemType: json["redeem_type"],
        usageStatus: json["usage_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "redeem_id": redeemId,
        "user_id": userId,
        "user_name": userName,
        "email": email,
        "coupon_id": couponId,
        "title": title,
        "restaurant_id": restaurantId,
        "description": description,
        "coupon_type": couponType,
        "discount_type": discountType,
        "discount_value": discountValue,
        "coupon_status": couponStatus,
        "redeem_type": redeemType,
        "usage_status": usageStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Meta {
  int? statusCode;
  String? status;
  String? message;

  Meta({
    this.statusCode,
    this.status,
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        statusCode: json["StatusCode"],
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Status": status,
        "Message": message,
      };
}
