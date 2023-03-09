import 'package:arkhive/tools/willpop_function.dart';
import 'package:flutter/material.dart';

class GimmickScreen extends StatefulWidget {
  const GimmickScreen({super.key});

  @override
  State<GimmickScreen> createState() => _GimmickScreenState();
}

class _GimmickScreenState extends State<GimmickScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: const Text('스테이지 기믹'),
      ),
    );
  }
}
