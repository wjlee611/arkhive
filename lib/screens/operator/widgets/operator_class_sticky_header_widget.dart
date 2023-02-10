import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class OperatorClassStickyHeader extends StatefulWidget {
  const OperatorClassStickyHeader({
    super.key,
    required this.controller,
    required this.controllHeaderOpen,
    required this.state,
    required this.index,
    required this.numOperators,
  });

  final ScrollController controller;
  final Function({
    required int index,
    required SliverStickyHeaderState state,
  }) controllHeaderOpen;
  final SliverStickyHeaderState state;
  final int index;
  final int numOperators;

  @override
  State<OperatorClassStickyHeader> createState() =>
      _OperatorClassStickyHeaderState();
}

class _OperatorClassStickyHeaderState extends State<OperatorClassStickyHeader> {
  bool isOpen = true;

  String _classImageSelector(int index) {
    if (index == 0) return "assets/images/class_vanguard.png";
    if (index == 1) return "assets/images/class_guard.png";
    if (index == 2) return "assets/images/class_defender.png";
    if (index == 3) return "assets/images/class_sniper.png";
    if (index == 4) return "assets/images/class_caster.png";
    if (index == 5) return "assets/images/class_medic.png";
    if (index == 6) return "assets/images/class_supporter.png";
    return "assets/images/class_specialist.png";
  }

  String _classTitleSelector(int index) {
    int numOps = widget.numOperators;
    if (index == 0) return "${OperatorPositions.vanguard}  /  $numOps";
    if (index == 1) return "${OperatorPositions.guard}  /  $numOps";
    if (index == 2) return "${OperatorPositions.defender}  /  $numOps";
    if (index == 3) return "${OperatorPositions.sniper}  /  $numOps";
    if (index == 4) return "${OperatorPositions.caster}  /  $numOps";
    if (index == 5) return "${OperatorPositions.medic}  /  $numOps";
    if (index == 6) return "${OperatorPositions.supporter}  /  $numOps";
    return "${OperatorPositions.specialist}  /  $numOps";
  }

  void _onOpenTap() {
    widget.controllHeaderOpen(
      index: widget.index,
      state: widget.state,
    );
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.size52,
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade700,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: Sizes.size2,
            spreadRadius: Sizes.size2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _classImageSelector(widget.index),
              width: Sizes.size32,
              height: Sizes.size32,
            ),
            Gaps.h10,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _classTitleSelector(widget.index),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onOpenTap,
                    child: AnimatedRotation(
                      turns: isOpen ? 0 : -0.5,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
