import "dart:convert";

import 'package:flutter/foundation.dart';

class BeliKarya {
  BeliKarya(
      {required this.id,
      required this.judul,
      required this.kategori,
      required this.deskripsi,
      required this.user,
      required this.harga,
      required this.tanggal,
      required this.sudah_dibeli});

  final int id;
  final String judul;
  final String kategori;
  final String deskripsi;
  final String user;
  final int harga;
  final String tanggal;
  final bool sudah_dibeli;

  factory BeliKarya.fromJson(Map<String, dynamic> json) => BeliKarya(
      id: json["id"],
      judul: json["judul"],
      kategori: json["kategori"],
      deskripsi: json["deskripsi"],
      user: json["user"],
      harga: json["harga"],
      tanggal: json["tanggal"],
      sudah_dibeli: json['sudah_dibeli']);
}

List<BeliKarya> parseBeliKarya(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<BeliKarya>((json) => BeliKarya.fromJson(json)).toList();
}
