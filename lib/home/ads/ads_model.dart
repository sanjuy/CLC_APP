class AdsModel {
  Meta? meta;
  List<AdsData>? data;

  AdsModel({
    this.meta,
    this.data,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<AdsData>.from(json["data"]!.map((x) => AdsData.fromJson(x))),
      );
}

class AdsData {
  String? id;
  String? name;
  String? images;
  DateTime? createdAt;
  DateTime? updatedAt;

  AdsData({
    this.id,
    this.name,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory AdsData.fromJson(Map<String, dynamic> json) => AdsData(
        id: json["id"],
        name: json["name"],
        images: json["images"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
