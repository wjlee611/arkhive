import 'package:Arkhive/models/font_family.dart';
import 'package:Arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import '../global_vars.dart' as globals;

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '오퍼레이터',
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
      body: ListView.separated(
        itemBuilder: (context, index) {
          final operator_ = globals.operators[index];
          return Text(operator_.name);
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: globals.operators.length,
      ),
      drawer: const NavDrawer(),
    );
  }
}
