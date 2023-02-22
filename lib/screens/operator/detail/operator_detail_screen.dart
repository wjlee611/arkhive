import 'dart:typed_data';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/detail/widgets/operator_detail_header_widget.dart';
import 'package:flutter/material.dart';

class OperatorDetailScreen extends StatefulWidget {
  const OperatorDetailScreen({
    super.key,
    required this.operator_,
    this.opImage,
  });

  final OperatorModel operator_;
  final Uint8List? opImage;

  @override
  State<OperatorDetailScreen> createState() => _OperatorDetailScreenState();
}

class _OperatorDetailScreenState extends State<OperatorDetailScreen> {
  int _potential = 0;
  int _elite = 0;
  int _level = 1;

  void _onPotSelected(int pot) {
    setState(() {
      _potential = pot;
    });
  }

  void _onEliteSelected(int elite) {
    setState(() {
      _elite = elite;
    });
  }

  void _onLevelChange(int level) {
    setState(() {
      _level = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "이력서",
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
            },
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.yellow.shade700,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: Column(
                children: [
                  Gaps.v130,
                  Text(widget.operator_.name!),
                ],
              ),
            ),
          ),
          OperatorDetailHeader(
            image: widget.opImage,
            operator_: widget.operator_,
            onPotSelected: _onPotSelected,
            onEliteSelected: _onEliteSelected,
            onLevelChange: _onLevelChange,
          ),
        ],
      ),
    );
  }
}
