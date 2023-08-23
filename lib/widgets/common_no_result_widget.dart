import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
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
          const AppFont(
            '검색 결과가 없습니다.',
            color: Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
