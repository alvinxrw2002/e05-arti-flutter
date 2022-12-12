import 'dart:html';

import 'package:e05_arti_flutter/BeliKarya/BeliKaryaModel.dart';
import 'package:e05_arti_flutter/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'BeliKaryaWidget.dart';

class BeliKaryaPage extends StatefulWidget {
  const BeliKaryaPage({Key? key}) : super(key: key);

  @override
  _BeliKaryaPageState createState() => _BeliKaryaPageState();
}

class _BeliKaryaPageState extends State<BeliKaryaPage> {
  List<BeliKarya> currentList = [];

  Future<List<BeliKarya>> fetchData() async {
    http.Client client = http.Client();
    final response = await client.get(Uri.parse(
        "https://arti-pbp-e05.up.railway.app/beli_karya/get-karyas-json"));
    if (response.statusCode == 200) {
      return compute(parseBeliKarya, response.body);
    } else {
      throw Exception("Fetch Data Gagal.");
    }
  }

  @override
  void initState() {
    fetchData().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              setState(() {
                currentList.add(value[i]);
              })
            }
        });
  }

  Widget _loading() {
    if (currentList.isEmpty) {
      return Center(
          child: Column(children: const <Widget>[
        SizedBox(height: 100),
        Text("Sedang mangambil data.."),
        SizedBox(height: 20),
        SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        )
      ]));
    } else {
      return ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentList.length,
        itemBuilder: ((context, index) {
          return cardTemplate(currentList[index], context);
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Beli Karya"),
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _loading(),
      ),
    );
  }
}
