class RegisterModel {
  Meta? meta;
  Data? data;

  RegisterModel({
    this.meta,
    this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  String? id;
  String? name;
  String? email;
  String? contactNo;
  String? gender;
  String? membershipType;
  String? userStatus;
  String? profilePicture;
  String? address;
  DateTime? createdAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.contactNo,
    this.gender,
    this.membershipType,
    this.userStatus,
    this.profilePicture,
    this.address,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: "${json["id"]}",
        name: json["name"],
        email: json["email"],
        contactNo: json["contact_no"],
        gender: json["gender"],
        membershipType: json["membership_type"],
        userStatus: json["user_status"],
        profilePicture: json["profile_picture"],
        address: json["address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
