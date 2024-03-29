import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';

enum TextType {
  sanity,
  rate,
}

class StagePenguinItemWidget extends StatelessWidget {
  final PenguinStageModel penguin;

  const StagePenguinItemWidget({
    super.key,
    required this.penguin,
  });

  String _imagePath(String? iconId) {
    if (iconId == null) {
      return 'assets/images/prts.png';
    }
    return 'assets/images/item/$iconId.png';
  }

  String _textFormatter({
    int? value,
    required TextType type,
  }) {
    if (value == null) return AppData.nullStr;

    switch (type) {
      case TextType.sanity:
        {
          return (value / 1000).toStringAsFixed(3);
        }
      case TextType.rate:
        {
          return '${(value / 10).toStringAsFixed(1)}%';
        }
    }
  }

  void _onTap(BuildContext context) {
    if (penguin.iconId == null) return;
    if (penguin.penguin == null || penguin.penguin!.itemId == null) return;

    OpenDetailScreen.onItemTab(
      itemKey: penguin.penguin!.itemId!,
      iconId: penguin.iconId!,
      name: penguin.name ?? penguin.penguin!.itemId!,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _onTap(context),
      child: Row(
        children: [
          Stack(
            children: [
              AssetImageWidget(
                path: _imagePath(penguin.iconId),
                width: Sizes.size52,
              ),
              if (penguin.isFirstDrop)
                Transform.translate(
                  offset: const Offset(0, Sizes.size6),
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                      ),
                      child: const AppFont(
                        '첫 드랍',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Gaps.h5,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFont(
                penguin.name ?? AppData.nullStr,
                fontWeight: FontWeight.w700,
              ),
              if (!penguin.isFirstDrop)
                Column(
                  children: [
                    Gaps.v3,
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: Sizes.size3),
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size1,
                            horizontal: Sizes.size3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(Sizes.size3),
                          ),
                          child: const AppFont(
                            '이성 효율',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        AppFont(
                          _textFormatter(
                            value: penguin.sanityx1000,
                            type: TextType.sanity,
                          ),
                        ),
                        Gaps.h10,
                        Container(
                          margin: const EdgeInsets.only(right: Sizes.size3),
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size1,
                            horizontal: Sizes.size3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(Sizes.size3),
                          ),
                          child: const AppFont(
                            '드랍률',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        AppFont(
                          _textFormatter(
                            value: penguin.ratex1000,
                            type: TextType.rate,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
