class EditProfileModel {
  Meta? meta;
  Data? data;

  EditProfileModel({
    this.meta,
    this.data,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) =>
      EditProfileModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? userId;
  String? name;
  String? email;
  String? contactNo;
  String? gender;
  String? membershipType;
  String? userStatus;
  String? profilePicture;
  String? address;
  DateTime? updatedAt;

  Data({
    this.userId,
    this.name,
    this.email,
    this.contactNo,
    this.gender,
    this.membershipType,
    this.userStatus,
    this.profilePicture,
    this.address,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        contactNo: json["contact_no"],
        gender: json["gender"],
        membershipType: json["membership_type"],
        userStatus: json["user_status"],
        profilePicture: json["profile_picture"],
        address: json["address"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
