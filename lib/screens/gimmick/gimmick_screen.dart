import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';

class GimmickScreen extends StatefulWidget {
  const GimmickScreen({super.key});

  @override
  State<GimmickScreen> createState() => _GimmickScreenState();
}

class _GimmickScreenState extends State<GimmickScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '스테이지 기믹',
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
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: const Text('스테이지 기믹'),
      ),
      drawer: const NavDrawer(),
    );
  }
}
