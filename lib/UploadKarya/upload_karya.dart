import 'dart:io';
import 'package:flutter/material.dart';
import 'package:e05_arti_flutter/drawer.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

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
  File? image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  Future<void> upload() async {
    var stream = ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri =
        Uri.parse("https://arti-pbp-e05.up.railway.app/post-karya-flutter");
    var request = MultipartRequest("POST", uri);
    request.fields['judul'] = judul;
    request.fields['harga'] = harga.toString();
    request.fields['kategori'] = kategori!;
    request.fields['deskripsi'] = deskripsi;

    var multiPartFile = MultipartFile('gambar', stream, length);
    request.files.add(multiPartFile);
    request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Karya'),
      ),
      drawer: const NavigationDrawer(),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  image != null
                      ? SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(
                            image!,
                            fit: BoxFit.contain,
                          ))
                      : Container(
                          padding: const EdgeInsets.all(100),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: const Text(
                            "Unggah karyamu",
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () async {
                        await getImage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Pilih Karya",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
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
                          return 'Deskripsi perlu ditambahkan';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonFormField(
                      value: kategori,
                      decoration: InputDecoration(
                        labelText: "Kategori",
                        hintText: "Pilih dari kategori yang tersedia",
                        // Menambahkan icon agar lebih intuitif
                        icon: const Icon(Icons.category_outlined),
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      items: listKategori.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      validator: (value) =>
                          value == null ? 'Kategori belum dipilih' : null,
                      onChanged: (String? newValue) {
                        setState(() {
                          kategori = newValue!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () async {
                        if (image == null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 15,
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    const Center(
                                        child: Text(
                                            'Pastikan karya sudah dipilih')),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Center(child: Text('Kembali')),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
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
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        const Center(
                                            child:
                                                Text('Berhasil menggunggah')),
                                        const SizedBox(height: 20),
                                        Text("Judul: $judul"),
                                        Text("Harga: $harga"),
                                        Text("Deskripsi: $deskripsi"),
                                        Text("Kategori: $kategori"),
                                        const SizedBox(height: 20),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UploadKarya()));
                                          },
                                          child: const Center(
                                              child: Text('Kembali')),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                            upload();
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
