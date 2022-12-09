import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e05_arti_flutter/drawer.dart';

class Pesan {
  String pesans;
  Pesan(this.pesans);
}

class Naro {
  static List<Pesan> contain = <Pesan>[];
}

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPage();
}

class _RiwayatPage extends State<RiwayatPage> {
  final _formKey = GlobalKey<FormState>();
  String pesan = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
      ),
      drawer: const NavigationDrawer(),
      body:
      // ListView.builder(
      //     itemCount: Naro.contain.length,
      //     itemBuilder: (context, index) {
      //       final item = Naro.contain[index];
      //       return ListTile(
      //         title:Text(item.pesans),
      //       );
      //     },
      // )
      Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pesan",
                    hintText: "Tulis pesan motivasimu disini",
                    // Menambahkan icon agar lebih intuitif
                    icon: const Icon(Icons.article_outlined),
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      pesan = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      pesan = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pesan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: Container(
                            child: ListView(
                              padding:
                                const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: <Widget>[
                                const Center(
                                  child: Text(
                                      'Data Berhasil Ditambahkan')),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  child: const Text('Kembali'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    Naro.contain.add(Pesan(pesan));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Kirim Pesan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}