import 'package:arkhive/tools/willpop_function.dart';
import 'package:flutter/material.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: const Text('스테이지 정보'),
      ),
    );
  }
}
