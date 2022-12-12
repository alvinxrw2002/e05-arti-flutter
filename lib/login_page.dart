// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:e05_arti_flutter/main.dart';
import "package:flutter/material.dart";
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

String username_loggedin = "";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                Text(
                  "Welcome to Arti!",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 48),
                TextField(
                  onChanged: (text) {
                    username = text;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter username",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter username",
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 48),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : TextButton(
                        child: const Text("Sign In"),
                        onPressed: () {
                          if (username == null || password == null) {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text("ssss"),
                              ),
                            );
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            _signIn(username!, password!, context);
                          }
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn(
      String username, String password, BuildContext context) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    const url = "https://arti-pbp-e05.up.railway.app/ajax-login";
    final response = await request.login(url, {
      "username": username,
      "password": password,
    });
    if (response["status"] == false) {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Akun belum terdaftar")),
      );
    } else {
      username_loggedin = username;
      log("Login berhasil");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "Arti"),
            settings: const RouteSettings(name: "Home"),
          ));
    }
    setState(() {
      isLoading = false;
    });
  }
}
