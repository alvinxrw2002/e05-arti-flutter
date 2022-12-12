import 'package:e05_arti_flutter/galeri/galeri_page.dart';
import 'package:flutter/material.dart';
import 'package:e05_arti_flutter/main.dart';
import 'package:e05_arti_flutter/UserProfile/pages/profile_page.dart';
import 'package:e05_arti_flutter/UploadKarya/upload_karya.dart';
import 'package:e05_arti_flutter/Leaderboard/pages/leaderboard_page.dart';
import 'package:e05_arti_flutter/Riwayat/riwayatpage.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:e05_arti_flutter/login_page.dart';
import 'package:e05_arti_flutter/register_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text('Daftar Fitur'),
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
          ListTile(
            title: const Text('Register'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
          ),
          ListTile(
            title: const Text('HomePage'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            title: const Text('Upload Karya'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const UploadKarya()));
            },
          ),
          ListTile(
            title: const Text('Lihat Galeri'),
            onTap: () {
              if (request.loggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GaleriPage()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const LoginPage())));
              }
            },
          ),
          ListTile(
              title: const Text('Leaderboard'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeaderboardPage()));
              }),
          ListTile(
            title: const Text('Riwayat'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RiwayatPage()));
            },
          ),
        ],
      ),
    );
  }
}
