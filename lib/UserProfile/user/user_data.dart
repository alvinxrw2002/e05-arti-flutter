import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e05_arti_flutter/UserProfile/user/userdatas.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image:
        "https://media.discordapp.net/attachments/993896108587745360/1051897283144323122/profiledefault.jpg?width=881&height=661",
    name: 'Zayn Malaka',
    email: 'test.test@gmail.com',
    phone: '081550397896',
    address:
        'Jl. Bangka IX',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
