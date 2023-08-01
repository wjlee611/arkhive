import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/base/penguin_model.dart';
import 'package:flutter/material.dart';

class ItemPenguinItemWidget extends StatelessWidget {
  final PenguinSortModel penguinData;
  final int idx;

  const ItemPenguinItemWidget({
    super.key,
    required this.penguinData,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    print(idx);
    return Container(
      padding: const EdgeInsets.all(Sizes.size10),
      margin: const EdgeInsets.only(top: Sizes.size5),
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('${idx + 1}'),
              Gaps.h20,
              Text('${penguinData.stageCode}'),
            ],
          ),
          Text('${penguinData.sanityx1000}'),
        ],
      ),
    );
  }
}
