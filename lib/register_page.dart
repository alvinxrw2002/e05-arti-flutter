import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:e05_arti_flutter/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
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
  String _pilihanKategori = "abstract";
  String _username = "";
  String _password1 = "";
  String _password2 = "";
  int status = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Container(
          child: Center(
            child: Container(
                height: 500,
                child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Register",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text("Username")),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: "Isi di sini",
                                ),
                                onChanged: (String? value) async {
                                  setState(() {
                                    _username = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    _username = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Text field tidak boleh kosong";
                                  }

                                  return null;
                                },
                              ),
                              const Text("Password"),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Isi di sini",
                                ),
                                onChanged: (String? value) async {
                                  setState(() {
                                    _password1 = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    _password1 = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Text field tidak boleh kosong";
                                  }

                                  return null;
                                },
                              ),
                              const Text("Ulangi password"),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Isi di sini",
                                ),
                                onChanged: (String? value) async {
                                  setState(() {
                                    _password2 = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    _password2 = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Text field tidak boleh kosong";
                                  }

                                  return null;
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.class_),
                                title: const Text(
                                  'Pilih kategori',
                                ),
                                trailing: DropdownButton(
                                  value: _pilihanKategori,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: listKategori.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _pilihanKategori = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final response = await request.post(
                                    "https://arti-pbp-e05.up.railway.app/ajax-register",
                                    {
                                      "username": _username,
                                      "password1": _password1,
                                      "password2": _password2,
                                      "kategori": _pilihanKategori,
                                    });

                                status = response["status"];
                                if (!mounted) return;
                                if (status == 1) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const SizedBox(
                                              width: 300,
                                              height: 200,
                                              child: Center(
                                                  child:
                                                      Text("Register Gagal")),
                                            ));
                                      });
                                }
                              }
                            }),
                      ],
                    ))),
          ),
        ));
  }
}
