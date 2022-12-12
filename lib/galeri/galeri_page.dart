import 'dart:convert';
import 'dart:developer';

import 'package:e05_arti_flutter/galeri/galeri_model.dart';
import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class GaleriPage extends StatelessWidget {
  const GaleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    const urlPath = "https://arti-pbp-e05.up.railway.app";

    return Scaffold(
        appBar: AppBar(
          title: const Text("Galeri", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color(0xffD4D6FF),
        ),
        body: FutureBuilder(
          future: _getGalleryData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                ),
                items: snapshot.data!.map((gallery) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Image.network(
                              '$urlPath${gallery.urlGambar}',
                              height: MediaQuery.of(context).size.height / 3,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text("Gagal menload data gambar.");
                              },
                            ),
                            const SizedBox(height: 8),
                            Text(
                              gallery.judul,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              "Deskripsi",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              gallery.deskripsi,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Harga",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              gallery.harga.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Kategori",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              gallery.kategori,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Tanggal",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              gallery.tanggal,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              gallery.pk.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _deleteKarya(context, gallery.pk);
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title:
                                        const Text("Sukses menghapus karaya"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GaleriPage(),
                                                ),
                                                (route) =>
                                                    route.settings.name ==
                                                    "Home");
                                          },
                                          child: const Text("Ok"))
                                    ],
                                  ),
                                );
                              },
                              child: const Text("Hapus Karya"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<List<GaleriModel>?> _getGalleryData(BuildContext context) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    List<GaleriModel> listGaleri = [];
    try {
      final response =
          await request.get("https://arti-pbp-e05.up.railway.app/galeri/json/");
      final data = response["data"] as List<dynamic>;
      for (var i = 0; i < data.length; i++) {
        listGaleri.add(GaleriModel.fromJson(data[i]));
      }
      return listGaleri;
    } catch (e) {
      log("ERROR: $e");
      return null;
    }
  }

  Future<void> _deleteKarya(BuildContext context, int id) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    final url = 'https://arti-pbp-e05.up.railway.app/galeri/delete-karya/$id';
    try {
      await request.get(url);
      log("Sukses hapus karya");
    } catch (e) {
      log("ERROR: $e");
    }
  }
}
