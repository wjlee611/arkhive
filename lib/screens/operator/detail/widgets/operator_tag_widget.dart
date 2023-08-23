import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class OperatorTagWrapWidget extends StatelessWidget {
  const OperatorTagWrapWidget({
    super.key,
    this.position,
    required this.tagList,
  });

  final String? position;
  final List<String> tagList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CommonTitleWidget(text: '태그'),
        Gaps.v5,
        Wrap(
          direction: Axis.horizontal,
          spacing: Sizes.size4,
          runSpacing: Sizes.size4,
          children: [
            if (position != null && position != 'NONE')
              OperatorTagWidget(
                tag: position! == 'MELEE'
                    ? '근거리'
                    : position! == 'RANGED'
                        ? '원거리'
                        : '근거리 원거리',
              ),
            for (var tag in tagList) OperatorTagWidget(tag: tag),
          ],
        ),
        Gaps.v32,
      ],
    );
  }
}

class OperatorTagWidget extends StatelessWidget {
  final String tag;

  const OperatorTagWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size7,
        horizontal: Sizes.size10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size20),
        color: Theme.of(context).primaryColor,
        border: Border.all(
          width: Sizes.size3 / Sizes.size2,
          color: Theme.of(context).shadowColor,
        ),
      ),
      child: AppFont(tag),
    );
  }
}
