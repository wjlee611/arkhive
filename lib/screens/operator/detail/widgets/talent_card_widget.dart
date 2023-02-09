import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class TalentCard extends StatelessWidget {
  const TalentCard({
    super.key,
    required this.talents,
  });

  final List<TalentModel> talents;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.size20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: Sizes.size5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.all(Sizes.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.yellow.shade700,
                  size: Sizes.size20,
                ),
                Gaps.h5,
                const Text(
                  "재능",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size10,
              right: Sizes.size10,
              top: Sizes.size10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var talent in talents)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size5,
                          vertical: Sizes.size2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size5),
                          color: Colors.blueGrey.shade600,
                        ),
                        child: Text(
                          talent.name,
                          style: const TextStyle(
                            fontSize: Sizes.size14,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Gaps.v3,
                      WrappedKoreanText(
                        talent.info,
                        style: const TextStyle(
                          fontSize: Sizes.size14,
                          fontFamily: FontFamily.nanumGothic,
                        ),
                      ),
                      Gaps.v10,
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
