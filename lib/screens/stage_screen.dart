import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';

class StageScreen extends StatefulWidget {
  const StageScreen({super.key});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '스테이지 정보',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: const Text('스테이지 정보'),
      drawer: const NavDrawer(),
    );
  }
}
