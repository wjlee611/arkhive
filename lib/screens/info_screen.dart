import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('정보'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: const Text('정보'),
    );
  }
}
