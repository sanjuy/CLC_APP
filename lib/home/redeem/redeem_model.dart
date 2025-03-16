class RedeemModel {
  Meta? meta;

  RedeemModel({
    this.meta,
  });

  factory RedeemModel.fromJson(Map<String, dynamic> json) => RedeemModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
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
