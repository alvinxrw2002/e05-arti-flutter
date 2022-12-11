import 'package:e05_arti_flutter/Leaderboard/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:e05_arti_flutter/drawer.dart';
import 'package:e05_arti_flutter/Leaderboard/models/user_extended.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:e05_arti_flutter/Leaderboard/models/gambar.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<LeaderboardPage> {
  List<Comment>? comments;
  int indexComment = 0;
  String _isiComment = "";
  int leaderboardState = 0;
  int indexGambar = 0;
  List<Gambar>? listGambar;

  final _formKey = GlobalKey<FormState>();
  Future<List<Comment>> fetchComment() async {
    final request = context.watch<CookieRequest>();
    // await request.login("https://arti-pbp-e05.up.railway.app/ajax-login", {
    //   "username": "bebek",
    //   "password": "ramyeon11",
    // });
    final response = await request
        .get("https://arti-pbp-e05.up.railway.app/leaderboard/change-comments");
    List<Comment> comments = [];
    for (Map<String, dynamic> elem in response) {
      comments.add(Comment.fromJson(elem));
    }
    return comments;
  }

  Future<List<UserExtended>> fetchUserExtended() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        "https://arti-pbp-e05.up.railway.app/leaderboard/leaderboard-pengguna");
    List<UserExtended> userExtended = [];
    for (Map<String, dynamic> elem in response) {
      userExtended.add(UserExtended.fromJson(elem));
    }
    List<UserExtended> res = [];
    for (int i = 0; i < userExtended.length && i < 10; i++) {
      res.add(userExtended[i]);
    }
    return res;
  }

  Future<List<Gambar>> fetchGambar() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        "https://arti-pbp-e05.up.railway.app/leaderboard/leaderboard-karya");
    List<Gambar> gambar = [];
    for (Map<String, dynamic> elem in response) {
      gambar.add(Gambar.fromJson(elem));
    }
    List<Gambar> res = [];
    for (int i = 0; i < gambar.length && i < 5; i++) {
      res.add(gambar[i]);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      drawer: const NavigationDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 64, 161, 226)),
              child: const Center(
                  child: Text(
                "Leaderboard",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.amber),
            child: Column(
              children: [
                const Text(
                  "Pilih Tipe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text("Pengguna"),
                        onPressed: () {
                          setState(() {
                            leaderboardState = 0;
                          });
                        },
                      ),
                      TextButton(
                        child: const Text("Karya"),
                        onPressed: () {
                          setState(() {
                            indexGambar = 0;
                            leaderboardState = 1;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 94, 7),
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(
                            top: 15, bottom: 35, right: 100, left: 100),
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: (() {
                          if (leaderboardState == 0) {
                            return FutureBuilder(
                              future: fetchUserExtended(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Column(
                                      children: List.generate(
                                          snapshot.data!.length,
                                          (index) => Text("${index + 1}. " +
                                              snapshot.data![index].fields
                                                  .username)));
                                }
                              },
                            );
                          }
                          return FutureBuilder(
                              future: fetchGambar(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  listGambar = snapshot.data;
                                  return Column(
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Image.network(
                                          "https://arti-pbp-e05.up.railway.app/media/" +
                                              listGambar![indexGambar].path,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: const Center(
                                                child: Text("Image Not Found"),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                                Icons.arrow_back_ios),
                                            onPressed: () {
                                              setState(() {
                                                if (indexGambar == 0) {
                                                  indexGambar =
                                                      listGambar!.length - 1;
                                                } else {
                                                  indexGambar--;
                                                }
                                              });
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.arrow_forward_ios),
                                            onPressed: () {
                                              setState(() {
                                                if (indexGambar ==
                                                    listGambar!.length - 1) {
                                                  indexGambar = 0;
                                                } else {
                                                  indexGambar++;
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                              });
                        }()))),
              ],
            ),
          ),
          Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 40, 128, 199)),
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        "Pilih Tipe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  FutureBuilder(
                    future: fetchComment(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        comments = snapshot.data!;
                        return Column(
                          children: [
                            Center(
                                child: Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 17, right: 7, left: 7, bottom: 50),
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Text(
                                              comments![indexComment]
                                                  .fields
                                                  .username,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            )),
                                        Text(comments![indexComment]
                                            .fields
                                            .text),
                                      ],
                                    )),
                              ),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    setState(() {
                                      if (indexComment == 0) {
                                        indexComment = comments!.length - 1;
                                      } else {
                                        indexComment--;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    setState(() {
                                      if (indexComment ==
                                          comments!.length - 1) {
                                        indexComment = 0;
                                      } else {
                                        indexComment++;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text("Kirim Komentar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(5),
                    child: Form(
                      key: _formKey,
                      child: Container(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Isi di sini",
                            ),
                            onChanged: (String? value) async {
                              setState(() {
                                _isiComment = value!;
                              });
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _isiComment = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Text field tidak boleh kosong";
                              }

                              return null;
                            },
                          )),
                    )),
                Container(
                  margin: const EdgeInsets.only(bottom: 21),
                  child: TextButton(
                    child: const Text("Submit"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.reset();
                        if (request.loggedIn) {
                          await request.post(
                              "https://arti-pbp-e05.up.railway.app/leaderboard/create-comment",
                              {
                                "text": _isiComment,
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const SizedBox(
                                      height: 200,
                                      width: 300,
                                      child: Center(
                                          child: Text(
                                              "Silahkan login terlebih dahulu")),
                                    ));
                              });
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
