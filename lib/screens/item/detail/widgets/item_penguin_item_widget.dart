import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/base/penguin_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPenguinItemWidget extends StatelessWidget {
  final PenguinItemModel penguinData;
  final int idx;

  const ItemPenguinItemWidget({
    super.key,
    required this.penguinData,
    required this.idx,
  });

  String _textSelector(BuildContext context) {
    var bloc = context.read<ItemPenguinBloc>();
    if (bloc.state.sortOption == null) return '계산 중';

    switch (bloc.state.sortOption!) {
      case PenguinSortOption.sanity:
        {
          return (penguinData.sanityx1000! / 1000).toStringAsFixed(3);
        }
      case PenguinSortOption.rate:
        {
          return '${(penguinData.ratex1000! / 10).toStringAsFixed(1)}%';
        }
      case PenguinSortOption.times:
        {
          return penguinData.times.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
        }
    }
  }

  void _onTap(BuildContext context) {
    if (penguinData.penguin.stageId == null) return;

    OpenDetailScreen.onStageTab(
      stageKey: penguinData.penguin.stageId!,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        height: Sizes.size40,
        margin: const EdgeInsets.only(
          top: Sizes.size5,
          left: Sizes.size5,
          right: Sizes.size5,
        ),
        padding: const EdgeInsets.only(right: Sizes.size20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(Sizes.size5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: Sizes.size40,
                      width: Sizes.size64,
                      decoration: const BoxDecoration(),
                      clipBehavior: Clip.hardEdge,
                      child: Transform.translate(
                        offset: const Offset(-Sizes.size32, -Sizes.size10),
                        child: Transform.rotate(
                          angle: 0.4,
                          child: Transform.scale(
                            scale: 1.6,
                            child: Container(
                              width: Sizes.size40,
                              height: Sizes.size40,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 0.1,
                                    blurRadius: 1,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: Sizes.size10),
                        child: AppFont(
                          '${idx + 1}',
                          color: Colors.white,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.9),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.h10,
                AppFont(
                  '${penguinData.stageCode}',
                  color: Colors.black54,
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                ),
                if (penguinData.diffGroup == 'NORMAL' ||
                    penguinData.diffGroup == 'TOUGH')
                  Container(
                    margin: const EdgeInsets.only(left: Sizes.size5),
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size2,
                      horizontal: Sizes.size5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size3),
                      color: penguinData.diffGroup == 'TOUGH'
                          ? Colors.redAccent
                          : Colors.blueAccent,
                    ),
                    child: AppFont(
                      penguinData.diffGroup == 'TOUGH' ? '고난' : '일반',
                      color: Colors.white,
                      fontSize: Sizes.size10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
            AppFont(
              _textSelector(context),
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
