import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class ItemPenguinHeaderWidget extends StatelessWidget {
  const ItemPenguinHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      collapsedHeight: 200,
      shadowColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Gaps.v32,
            const CommonTitleWidget(text: '획득 방법 - 분석'),
            Text(
              '* Powered by penguin-stats.io',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: FontFamily.nanumGothic,
                fontSize: Sizes.size10,
              ),
            ),
            Gaps.v3,
            Text(
              '* Last Update: 0000-00-00',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: FontFamily.nanumGothic,
                fontSize: Sizes.size10,
              ),
            ),
            Gaps.v16,
            Row(
              children: [
                Text(
                  PenguinSortOption.sanity.message,
                  style: TextStyle(
                    color: Colors.yellow.shade700,
                  ),
                ),
                Gaps.h5,
                Text(PenguinSortOption.rate.message),
                Gaps.h5,
                Text(PenguinSortOption.times.message),
              ],
            ),
            Gaps.v10,
            Container(
              padding: const EdgeInsets.all(Sizes.size10),
              margin: const EdgeInsets.only(top: Sizes.size5),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('순위'),
                      Gaps.h20,
                      Text('스테이지'),
                    ],
                  ),
                  Text('이성/1개'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
