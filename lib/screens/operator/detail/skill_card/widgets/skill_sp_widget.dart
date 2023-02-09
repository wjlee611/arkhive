import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class SkillSP extends StatelessWidget {
  const SkillSP({
    super.key,
    required this.sp,
  });

  final String sp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size3,
            vertical: Sizes.size1,
          ),
          margin: const EdgeInsets.only(left: Sizes.size5),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(Sizes.size5),
          ),
          child: const Text(
            'SP',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.nanumGothic,
              color: Colors.white,
            ),
          ),
        ),
        if (sp.split('/').length == 2)
          Row(
            children: [
              Gaps.h5,
              Text(
                sp.split('/')[0],
                style: const TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.nanumGothic,
                  color: Colors.blue,
                ),
              ),
              const Icon(
                Icons.arrow_right,
                color: Colors.blue,
                size: Sizes.size16 + Sizes.size2,
              ),
              Text(
                sp.split('/')[1],
                style: const TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.nanumGothic,
                  color: Colors.blue,
                ),
              ),
            ],
          )
        else
          const Padding(
            padding: EdgeInsets.only(left: Sizes.size5),
            child: Text(
              "즉시 시전",
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.nanumGothic,
                color: Colors.blue,
              ),
            ),
          ),
      ],
    );
  }
}
