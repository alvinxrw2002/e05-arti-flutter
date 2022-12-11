import 'dart:convert';

class Gambar {
  Gambar({required this.path});

  String path;

  factory Gambar.fromJson(Map<String, dynamic> data) => Gambar(
        path: data["fields"]["gambar"],
      );
}
