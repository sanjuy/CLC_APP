class CouponListModelModel {
  Meta? meta;
  List<AllCouponsList>? data;

  CouponListModelModel({
    this.meta,
    this.data,
  });

  factory CouponListModelModel.fromJson(Map<String, dynamic> json) =>
      CouponListModelModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
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
  String? usageStatus;
  String? location;
  String? url;
  String? ins1;
  String? ins2;
  String? ins3;
  String? restaurantName;
  String? restaurantPhone;
  String? restaurantEmail;
  String? restaurantAddress;
  String? restaurantLogo;
  String? createdAt;
  String? updatedAt;
  String? restaurantCreatedDate;
  String? restaurantUpdatedDate;

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
    this.usageStatus,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.url,
    this.ins1,
    this.ins2,
    this.ins3,
    this.restaurantName,
    this.restaurantPhone,
    this.restaurantEmail,
    this.restaurantAddress,
    this.restaurantLogo,
    this.restaurantCreatedDate,
    this.restaurantUpdatedDate,
  });

  factory AllCouponsList.fromJson(Map<String, dynamic> json) => AllCouponsList(
        couponId: "${json["coupon_id"]}",
        title: json["title"],
        restaurantId: "${json["restaurant_id"]}",
        description: json["description"],
        couponType: json["coupon_type"],
        membershipType: json["membership_type"],
        discountType: json["discount_type"],
        discountValue: json["discount_value"],
        couponStatus: json["coupon_status"],
        usageStatus: json["usage_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        location: json["location"],
        url: json["url"],
        ins1: json["ins1"],
        ins2: json["ins2"],
        ins3: json["ins3"],
        restaurantName: json["restaurant_name"],
        restaurantPhone: json["restaurant_phone"],
        restaurantEmail: json["restaurant_email"],
        restaurantAddress: json["restaurant_address"],
        restaurantLogo: json["restaurant_logo"],
        restaurantCreatedDate: json["restaurant_created_date"],
        restaurantUpdatedDate: json["restaurant_updated_date"],
      );
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
}
