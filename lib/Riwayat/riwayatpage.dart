import 'dart:developer';

import 'package:e05_arti_flutter/Riwayat/pesan_provider.dart';
import "package:flutter/material.dart";
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  String? isi;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Riwayat", style: TextStyle(color: Colors.white)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                                    fontWeight: FontWeight.bold, fontSize: 20));
                          } else {
                            return const Text("Sedang mendapatkan data...");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      "Pesan Motivasi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    Consumer<PesanProvider>(
                      builder: (context, value, child) {
                        return FutureBuilder(
                          future:
                              Provider.of<PesanProvider>(context, listen: false)
                                  .fetchPesan(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Expanded(
                                child: GridView.builder(
                                  itemCount: snapshot.data!.length,
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
                                      padding: const EdgeInsets.all(16),
                                      decoration: const BoxDecoration(
                                          color: Color(0xffD4D6FF),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25))),
                                      child: Column(
                                        children: [
                                          Text(snapshot.data![index].isi),
                                          const Spacer(),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '-${snapshot.data![index].nama}',
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                !snapshot.hasData) {
                              return const Text(
                                  "Gagal mendapatkan data pesan-pesan.");
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<PesanProvider>(context,
                                              listen: false)
                                          .addPesan(context, isi!);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Kirim Pesan"),
                                  ),
                                ],
                                title: Text('Pesan Motivasi'),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: 'Pesan',
                                            icon: Icon(Icons.message),
                                          ),
                                          onChanged: (value) {
                                            isi = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color(0xffD4D6FF),
                          ),
                          minimumSize: MaterialStatePropertyAll(
                            Size(double.infinity, 44),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                          )),
                      child: const Center(child: Text("Tambah Pesan")),
                    ),
                    const SizedBox(height: 12),
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
