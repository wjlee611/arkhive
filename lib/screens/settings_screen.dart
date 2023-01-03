import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('설정'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: const Text('설정'),
    );
  }
}
