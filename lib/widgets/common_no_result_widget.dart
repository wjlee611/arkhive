import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class CommonNoResultWidget extends StatelessWidget {
  const CommonNoResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/prts.png',
            color: Colors.grey.shade400,
            width: Sizes.size60,
            height: Sizes.size60,
          ),
          Gaps.v5,
          const Text(
            '검색 결과가 없습니다.',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.nanumGothic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
