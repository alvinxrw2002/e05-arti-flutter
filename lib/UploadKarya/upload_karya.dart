import 'package:flutter/material.dart';
import 'package:e05_arti_flutter/drawer.dart';
import 'package:flutter/services.dart';

class UploadKarya extends StatefulWidget {
  const UploadKarya({super.key});

  @override
  State<UploadKarya> createState() => _UploadKaryaState();
}

class _UploadKaryaState extends State<UploadKarya> {
  final _formKey = GlobalKey<FormState>();
  String judul = "";
  List<String> listKategori = [
    'abstract',
    'cartoon',
    'college',
    'doodle',
    'drawing',
    'hologram',
    'life drawing',
    'scribbles',
    'silhoutte',
    'sketch'
  ];
  String? kategori;
  int harga = 0;
  String deskripsi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Karya'),
      ),
      drawer: const NavigationDrawer(),
      body: Form(
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
                    labelText: "Judul Karya",
                    hintText: "Masukkan judul karyamu",
                    // Menambahkan icon agar lebih intuitif
                    icon: const Icon(Icons.title),
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      judul = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      judul = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Harga (Rp)",
                    hintText: "Masukkan dalam format angka",
                    icon: const Icon(Icons.price_change),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      harga = int.parse(value!);
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      harga = int.parse(value!);
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'harga harus diisi';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    hintText: "Deskripsi singkat mengenai karyamu",
                    // Menambahkan icon agar lebih intuitif
                    icon: const Icon(Icons.description),
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      deskripsi = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      deskripsi = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: kategori,
                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const Text("Kategori Karya"),
                  items: listKategori.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      kategori = newValue!;
                    });
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
                          child: ListView(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            shrinkWrap: true,
                            children: <Widget>[
                              const Center(child: Text('Informasi Data')),
                              const SizedBox(height: 20),
                              Text("Judul: $judul"),
                              Text("Kategori: $kategori"),
                              Text("Harga: RP$harga"),
                              Text("Deskripsi: $deskripsi"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Kembali'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Simpan",
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
