import 'package:flutter/material.dart';

class GimmickScreen extends StatefulWidget {
  const GimmickScreen({super.key});

  @override
  State<GimmickScreen> createState() => _GimmickScreenState();
}

class _GimmickScreenState extends State<GimmickScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('스테이지 기믹'),
    );
  }
}
