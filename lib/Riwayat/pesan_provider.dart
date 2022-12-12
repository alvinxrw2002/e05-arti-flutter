import 'dart:developer';

import 'package:e05_arti_flutter/Riwayat/pesan_model.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class PesanProvider extends ChangeNotifier {
  List<PesanModel> _listPesan = [];

  List<PesanModel> get listPesan => _listPesan;

  Future<List<PesanModel>?> fetchPesan(BuildContext context) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    const url = "https://arti-pbp-e05.up.railway.app/riwayat/pesanajax/?q=";
    List<PesanModel> newListPesan = [];

    try {
      final response = await request.get(url) as List<dynamic>;
      for (var i = 0; i < response.length; i++) {
        newListPesan.add(PesanModel.fromJson(response[i]));
      }
      _listPesan = newListPesan;
      return newListPesan;
    } catch (error) {
      log("ERROR: $error");
      return null;
    }
  }

  Future<void> addPesan(BuildContext context, String isi) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    final url = 'https://arti-pbp-e05.up.railway.app/riwayat/pesanajax/?q=$isi';
    try {
      await request.get(url);
      notifyListeners();
    } catch (error) {
      log('ERROR: $error');
    }
  }
}
