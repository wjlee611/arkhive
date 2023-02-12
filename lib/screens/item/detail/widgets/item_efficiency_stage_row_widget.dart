import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class EfficiencyStageRow extends StatelessWidget {
  const EfficiencyStageRow({
    Key? key,
    required this.index,
    required this.stage,
    required this.efficiency,
  }) : super(key: key);

  final int index;
  final String stage;
  final String efficiency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size3,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        color:
            index % 2 == 0 ? Colors.blueGrey.shade50 : Colors.blueGrey.shade100,
        border: Border(
          left: BorderSide(
            color: Colors.blueGrey.shade700,
            width: Sizes.size3,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: Sizes.size5),
            padding: const EdgeInsets.all(Sizes.size5),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
            child: Row(
              children: [
                Text(
                  stage.replaceAll('_S', '').replaceAll('_T', ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.size14,
                  ),
                ),
                if (stage.contains('_S')) const StageLevelTag(isTough: false),
                if (stage.contains('_T')) const StageLevelTag(isTough: true),
              ],
            ),
          ),
          Text(
            efficiency != '0.00' ? efficiency : '확정',
            style: TextStyle(
              color: index == 0 && efficiency != '0.00'
                  ? Colors.yellow.shade900
                  : Colors.blueGrey.shade700,
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size16,
            ),
          ),
        ],
      ),
    );
  }
}

class StageLevelTag extends StatelessWidget {
  const StageLevelTag({
    super.key,
    required this.isTough,
  });

  final bool isTough;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Sizes.size5),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size1,
        horizontal: Sizes.size3,
      ),
      decoration: BoxDecoration(
        color: isTough ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(Sizes.size5),
      ),
      child: Text(
        isTough ? '시련' : '일반',
        style: const TextStyle(
          color: Colors.white,
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
          fontSize: Sizes.size14,
        ),
      ),
    );
  }
}
