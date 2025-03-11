class CouponListModelModel {
  Meta? meta;

  CouponListModelModel({
    this.meta,
  });

  factory CouponListModelModel.fromJson(Map<String, dynamic> json) =>
      CouponListModelModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );
}

class Meta {
  int? statusCode;
  String? status;
  String? message;
  List<AllCouponsList>? data;

  Meta({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        statusCode: json["StatusCode"],
        status: json["Status"],
        message: json["Message"],
        data: json["data"] == null
            ? []
            : List<AllCouponsList>.from(
                json["data"]!.map((x) => AllCouponsList.fromJson(x))),
      );
}

class AllCouponsList {
  String? couponId;
  String? title;
  String? restaurantId;
  String? description;
  String? couponType;
  String? membershipType;
  String? discountType;
  String? discountValue;
  String? couponStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  AllCouponsList({
    this.couponId,
    this.title,
    this.restaurantId,
    this.description,
    this.couponType,
    this.membershipType,
    this.discountType,
    this.discountValue,
    this.couponStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory AllCouponsList.fromJson(Map<String, dynamic> json) => AllCouponsList(
        couponId: json["coupon_id"],
        title: json["title"],
        restaurantId: json["restaurant_id"],
        description: json["description"],
        couponType: json["coupon_type"],
        membershipType: json["membership_type"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        couponStatus: json["coupon_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
