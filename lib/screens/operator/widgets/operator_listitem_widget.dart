import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/tools/load_image_from_securestorage.dart';
import 'package:flutter/material.dart';

class OperatorListItem extends StatelessWidget {
  const OperatorListItem({
    super.key,
    required this.operator_,
    required this.index,
  });

  final OperatorModel operator_;
  final int index;

  Color _rarityColorSelector(int rarity) {
    if (rarity == 5) return Colors.white;
    if (rarity == 4) return Colors.yellow.shade700;
    return Colors.grey.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
      ),
      child: FutureBuilder(
        future: getImageFromSP(
            "image/operator/${operator_.phases.first.characterPrefabKey}"),
        builder: (context, snapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Sizes.size52,
                width: Sizes.size5,
                decoration: BoxDecoration(
                  color: _rarityColorSelector(operator_.rarity!),
                ),
              ),
              Hero(
                tag: operator_.phases.first.characterPrefabKey!,
                child: Container(
                  width: Sizes.size52,
                  height: Sizes.size52,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(),
                  child: snapshot.hasData
                      ? Image.memory(
                          snapshot.data!,
                          width: Sizes.size52,
                          height: Sizes.size52,
                          gaplessPlayback: true,
                        )
                      : Image.asset(
                          "assets/images/prts.png",
                          width: Sizes.size52,
                          height: Sizes.size52,
                        ),
                ),
              ),
              Gaps.h20,
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        operator_.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: Sizes.size14,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
