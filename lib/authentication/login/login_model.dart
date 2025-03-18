class LoginModel {
  Meta? meta;
  Data? data;

  LoginModel({
    this.meta,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? userId;
  String? name;
  String? email;
  String? address;
  String? profilePicture;
  String? contactNo;
  String? gender;
  String? membershipType;
  String? userStatus;
  String? createdAt;
  String? updatedAt;
  String? otp;
  String? otpExpiry;

  Data({
    this.userId,
    this.name,
    this.email,
    this.address,
    this.profilePicture,
    this.contactNo,
    this.gender,
    this.membershipType,
    this.userStatus,
    this.createdAt,
    this.updatedAt,
    this.otp,
    this.otpExpiry,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: "${json["user_id"]}",
        name: json["name"],
        email: json["email"],
        address: json["address"],
        profilePicture: json["profile_picture"],
        contactNo: "${json["contact_no"]}",
        gender: json["gender"],
        membershipType: json["membership_type"],
        userStatus: json["user_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        otp: json["otp"],
        otpExpiry: json["otp_expiry"],
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
