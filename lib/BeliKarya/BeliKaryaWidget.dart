import 'dart:js';

import 'package:e05_arti_flutter/BeliKarya/BeliKarya.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BeliKaryaModel.dart';

Widget cardTemplate(BeliKarya beliKarya, context) {
  return Card(
    elevation: 24,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    shadowColor: Colors.black38,
    margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                beliKarya.judul,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)))),
              onPressed: () {},
              child: Text(
                beliKarya.kategori,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            Text(beliKarya.deskripsi,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              ("Rp. ${beliKarya.harga}"),
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 5,
            ),
            keteranganDiBeli(beliKarya.sudah_dibeli),
            const SizedBox(
              height: 5,
            ),
            beliButton(context, beliKarya.sudah_dibeli, beliKarya.id)
          ]),
    ),
  );
}

Widget keteranganDiBeli(bool sudahDiBeli) {
  if (sudahDiBeli) {
    return Text("Sudah dibeli");
  } else {
    return Text("Belum dibeli");
  }
}

Widget beliButton(BuildContext context, bool sudahDiBeli, int id) {
  if (!sudahDiBeli) {
    return ElevatedButton(
        onPressed: () async {
          String destination =
              "http://127.0.0.1:8000/beli_karya/post-beli-karya-json";
          var url = Uri.parse(destination);
          final response = await http.post(url,
              headers: {'Content-Type': 'application/json'},
              body: json.encode({'id': id}));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BeliKaryaPage()));
        },
        child: const Text("Beli"));
  } else {
    return const ElevatedButton(onPressed: null, child: Text("Beli"));
  }
}
