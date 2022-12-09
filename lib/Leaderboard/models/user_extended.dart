// To parse this JSON data, do
//
//     final userExtended = userExtendedFromJson(jsonString);

import 'dart:convert';

List<UserExtended> userExtendedFromJson(String str) => List<UserExtended>.from(
    json.decode(str).map((x) => UserExtended.fromJson(x)));

String userExtendedToJson(List<UserExtended> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserExtended {
  UserExtended({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory UserExtended.fromJson(Map<String, dynamic> json) => UserExtended(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.username,
    required this.pembelian,
  });

  int user;
  String username;
  int pembelian;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        pembelian: json["pembelian"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "pembelian": pembelian,
      };
}
