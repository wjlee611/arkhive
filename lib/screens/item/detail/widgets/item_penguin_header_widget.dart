import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_event.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_sort_btn.dart';
import 'package:arkhive/widgets/app_font.dart';
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
      toolbarHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Gaps.v32,
            const CommonTitleWidget(text: '획득 방법 - 분석'),
            SizedBox(
              height: Sizes.size28,
              child: Column(
                children: [
                  BlocBuilder<PenguinCubit, PenguinState>(
                      builder: (context, state) {
                    return AppFont(
                      '* Powered by penguin-stats.io, ${state.server?.region ?? '-'} Server',
                      color: Colors.grey.shade700,
                      fontSize: Sizes.size10,
                    );
                  }),
                  Gaps.v2,
                  AppFont(
                    '* Last Update: 2023.08.01',
                    color: Colors.grey.shade700,
                    fontSize: Sizes.size10,
                  ),
                ],
              ),
            ),
            Gaps.v20,
            Container(
              height: Sizes.size36,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  const Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ItemPenguinSortBtn(
                              sortOption: PenguinSortOption.sanity),
                          Gaps.h5,
                          ItemPenguinSortBtn(
                              sortOption: PenguinSortOption.rate),
                          Gaps.h5,
                          ItemPenguinSortBtn(
                              sortOption: PenguinSortOption.times),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<ItemPenguinBloc, ItemPenguinState>(
                    builder: (context, state) => Row(
                      children: [
                        AppFont(
                          state.isIncludePerm ? '비 상시맵\n포함 됨' : '상시맵 만\n포함 됨',
                          color: Colors.black54,
                          fontSize: Sizes.size10,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.right,
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
            ),
            Gaps.v5,
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
              height: Sizes.size28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      AppFont(
                        '순위',
                        color: Colors.black54,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w700,
                      ),
                      Gaps.h36,
                      AppFont(
                        '스테이지',
                        color: Colors.black54,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  BlocBuilder<ItemPenguinBloc, ItemPenguinState>(
                    builder: (context, state) => AppFont(
                      '단위: ${state.sortOption?.unit ?? '-'}',
                      color: Colors.black54,
                      // fontSize: Sizes.size14,
                      fontWeight: FontWeight.w700,
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
