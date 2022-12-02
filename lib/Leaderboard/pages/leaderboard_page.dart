import 'package:flutter/material.dart';
import 'package:e05_arti_flutter/drawer.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _Leaderboard();
}

class _Leaderboard extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      drawer: const NavigationDrawer(),
      body: const Text("Leaderboard"),
    );
  }
}
