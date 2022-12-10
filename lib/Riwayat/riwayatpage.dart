import 'dart:developer';

import "package:flutter/material.dart";
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Riwayat", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color(0xffD4D6FF),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    const Text(
                      "Donasi Terkumpul",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xffD4D6FF),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: FutureBuilder(
                        future: _getDonationData(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Text('Rp. ${snapshot.data!}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16));
                          } else {
                            return const Text("Sedang mendapatkan data...");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      "Pesan Motivasi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: 5,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Color(0xffD4D6FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffD4D6FF))),
                      child: const Text("Tambah Pesan"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getDonationData(BuildContext context) async {
    final request = context.watch<CookieRequest>();
    final response = await request
        .get("https://arti-pbp-e05.up.railway.app/beli_karya/get-karyas");
    final convertedResponse = response as List<dynamic>;
    int totalDonasi = 0;
    for (var i = 0; i < convertedResponse.length; i++) {
      totalDonasi = totalDonasi + convertedResponse[i]["harga"] as int;
    }
    log(totalDonasi.toString());
    return totalDonasi.toString();
  }
}

