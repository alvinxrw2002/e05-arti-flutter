// To parse this JSON data, do
//
//     final dataJson = dataJsonFromJson(jsonString);

import 'dart:convert';

List<DataJson> dataJsonFromJson(String str) => List<DataJson>.from(json.decode(str).map((x) => DataJson.fromJson(x)));

String dataJsonToJson(List<DataJson> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataJson {
    DataJson({
        required this.username,
        required this.email,
        required this.phone,
        required this.address,
    });

    String username;
    String email;
    String phone;
    String address;

    static DataJson fromJson(Map<String, dynamic> json) => DataJson(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
    };

}
