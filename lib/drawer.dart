import 'package:flutter/material.dart';
import 'package:e05_arti_flutter/main.dart';
import 'package:e05_arti_flutter/UserProfile/pages/profile_page.dart';
import 'package:e05_arti_flutter/UploadKarya/upload_karya.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text('Daftar Fitur'),
          ),
          ListTile(
            title: const Text('HomePage'),
            onTap: () {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context)=> const MyApp())
              );
            },
          ),

          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context)=> ProfilePage())
              );
            },
          ),

          ListTile(
            title: const Text('Upload Karya'),
            onTap: () {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context)=> const UploadKarya())
              );
            },
          ),
        ],
      ),
    );
  }
}
