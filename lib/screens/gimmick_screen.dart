import 'package:Arkhive/widgets/nav_widget.dart';
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
        title: const Text('스테이지 기믹'),
        backgroundColor: Colors.blueGrey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: const Text('스테이지 기믹'),
      drawer: const NavDrawer(),
    );
  }
}
