import 'dart:convert';
import 'package:Arkhive/models/font_family.dart';
import 'package:Arkhive/models/operator_model.dart';
import 'package:Arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key});

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<OperatorModel>> readOperatorJson() async {
    List<OperatorModel> operators = [];
    final String res =
        await rootBundle.loadString('assets/json/data_operator.json');
    final data = await json.decode(res)['data'];
    for (var jsonData in data) {
      operators.add(OperatorModel.fromJson(jsonData));
    }
    return operators;
  }

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
      body: FutureBuilder(
        future: readOperatorJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final operator_ = snapshot.data![index];
                return Text(operator_.name);
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: snapshot.data!.length,
            );
          }
          return const Text('...');
        },
      ),
      drawer: const NavDrawer(),
    );
  }
}
