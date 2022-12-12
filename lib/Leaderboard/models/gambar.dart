import 'dart:convert';

class Gambar {
  Gambar({required this.path, required this.harga, required this.judul});

  String path;
  int harga;
  String judul;

  factory Gambar.fromJson(Map<String, dynamic> data) => Gambar(
        path: data["fields"]["gambar"],
        harga: data["fields"]["harga"],
        judul: data["fields"]["judul"],
      );
}
