import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/models/font_family.dart';
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
      height: Sizes.size40,
      margin: const EdgeInsets.only(
        top: Sizes.size5,
        left: Sizes.size5,
        right: Sizes.size5,
      ),
      padding: const EdgeInsets.only(right: Sizes.size20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(Sizes.size5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: Sizes.size40,
                    width: Sizes.size64,
                    decoration: const BoxDecoration(),
                    clipBehavior: Clip.hardEdge,
                    child: Transform.translate(
                      offset: const Offset(-Sizes.size32, -Sizes.size10),
                      child: Transform.rotate(
                        angle: 0.4,
                        child: Transform.scale(
                          scale: 1.6,
                          child: Container(
                            width: Sizes.size40,
                            height: Sizes.size40,
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade700,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 0.1,
                                  blurRadius: 1,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Sizes.size10),
                      child: Text(
                        '${idx + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.nanumGothic,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.9),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.h10,
              Text(
                '${penguinData.stageCode}',
                style: const TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                  fontSize: Sizes.size16,
                ),
              ),
            ],
          ),
          Text(
            (penguinData.sanityx1000! / 1000).toStringAsFixed(3),
            style: const TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
