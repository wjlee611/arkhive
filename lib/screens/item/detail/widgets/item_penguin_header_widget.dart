import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_event.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_sort_btn.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPenguinHeaderWidget extends StatelessWidget {
  const ItemPenguinHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      collapsedHeight: 201,
      shadowColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Gaps.v32,
            const CommonTitleWidget(text: '획득 방법 - 분석'),
            SizedBox(
              height: Sizes.size28,
              child: Column(
                children: [
                  Text(
                    '* Powered by penguin-stats.io',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size10,
                    ),
                  ),
                  Gaps.v2,
                  Text(
                    '* Last Update: 0000-00-00',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: FontFamily.nanumGothic,
                      fontSize: Sizes.size10,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.v20,
            Row(
              children: [
                const Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ItemPenguinSortBtn(
                            sortOption: PenguinSortOption.sanity),
                        Gaps.h5,
                        ItemPenguinSortBtn(sortOption: PenguinSortOption.rate),
                        Gaps.h5,
                        ItemPenguinSortBtn(sortOption: PenguinSortOption.times),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ItemPenguinBloc, ItemPenguinState>(
                  builder: (context, state) => Row(
                    children: [
                      Text(
                        state.isIncludePerm ? '비 상시맵\n포함 됨' : '상시맵 만\n포함 됨',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontSize: Sizes.size10,
                        ),
                      ),
                      Switch(
                        value: state.isIncludePerm,
                        activeColor: Colors.yellow.shade700,
                        onChanged: (value) {
                          context
                              .read<ItemPenguinBloc>()
                              .add(ItemPenguinToggleEvent(
                                isIncludePerm: value,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                bottom: Sizes.size10,
                left: Sizes.size10,
                right: Sizes.size20,
              ),
              margin: const EdgeInsets.only(top: Sizes.size5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: Sizes.size2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        '순위',
                        style: TextStyle(
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontSize: Sizes.size14,
                        ),
                      ),
                      Gaps.h36,
                      Text(
                        '스테이지',
                        style: TextStyle(
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontSize: Sizes.size14,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ItemPenguinBloc, ItemPenguinState>(
                    builder: (context, state) => Text(
                      '단위: ${state.sortOption?.unit ?? '-'}',
                      style: const TextStyle(
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
