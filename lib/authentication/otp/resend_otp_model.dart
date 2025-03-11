class ResendOtpModel {
  Meta? meta;
  Data? data;

  ResendOtpModel({
    this.meta,
    this.data,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) => ResendOtpModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? id;
  int? otp;

  Data({
    this.id,
    this.otp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        otp: json["otp"],
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
