import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class ManualWidget extends StatelessWidget {
  const ManualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.all(Sizes.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Colors.yellow.shade700,
                  size: Sizes.size20,
                ),
                const SizedBox(
                  width: Sizes.size5,
                ),
                const Text(
                  "설명서",
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
            padding: const EdgeInsets.all(Sizes.size10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ManualText(text: '안녕하세요 박사님.'),
                const ManualText(
                    text: 'Arkhive 소개를 도와드릴 로도스 아일랜드 인공지능 비서 PRTS입니다.'),
                Gaps.v12,
                const ManualText(
                    text:
                        'Arkhive는 로도스 아일랜드를 비롯한 테라에 존재하는 생명체, 물건, 현상 등 거의 모든 정보를 제공하여 박사님의 업무를 도와드립니다.'),
                Gaps.v10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    ManualText(
                      text: '최상단에 ',
                      isBold: true,
                    ),
                    Icon(
                      Icons.sort,
                      size: Sizes.size16,
                    ),
                    ManualText(
                      text: '이 보이시나요?',
                      isBold: true,
                    ),
                  ],
                ),
                const ManualText(
                    text: '메뉴 바를 열어 데이터베이스에 저장된 모든 자료를 열람하실 수 있습니다.'),
                Gaps.v10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const ManualText(
                      text: '각 자료마다 상단에 ',
                      isBold: true,
                    ),
                    Icon(
                      Icons.star_border_outlined,
                      color: Colors.yellow.shade700,
                      size: Sizes.size16,
                    ),
                    const ManualText(
                      text: '이 존재합니다.',
                      isBold: true,
                    ),
                  ],
                ),
                const ManualText(
                  text: "누르시면 앞으로 메인 화면 - 즐겨찾기 에서 빠르게 접근하실 수 있습니다.",
                ),
                const ManualText(
                  text: "한번 더 누르시면 즐겨찾기에서 제거됩니다.",
                ),
                Gaps.v12,
                const ManualText(
                  text: '이상 설명을 마치도록 하겠습니다.',
                ),
                const ManualText(
                  text: '좋은 하루 되세요, 박사님.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManualText extends StatelessWidget {
  const ManualText({
    super.key,
    required this.text,
    this.isBold = false,
  });

  final String text;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Sizes.size14,
        fontFamily: FontFamily.nanumGothic,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
