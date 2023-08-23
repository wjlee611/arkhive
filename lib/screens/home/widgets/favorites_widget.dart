import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: Sizes.size5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.all(Sizes.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: Sizes.size20,
                ),
                Gaps.h5,
                const AppFont(
                  "즐겨찾기",
                  color: Colors.white,
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(Sizes.size10),
            // TODO: 즐겨찾기 저장 시: 카테고리,사진이름,이름
            // 즐겨찾기 불러올 시: split후, [1], [2]로 아이콘 추가
            // 즐겨찾기 클릭 시: [0]에서 [2]이름 탐색 후 [0]에 맟는 화면 띄워주기
            child: AppFont(
              "즐겨찾기에 동록된 항목이 없습니다.",
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
    );
  }
}
