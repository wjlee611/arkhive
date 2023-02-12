import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/screens/item/detail/widgets/item_detail_title_widget.dart';
import 'package:arkhive/screens/item/detail/widgets/item_efficiency_stage_row_widget.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class ItemDetailScreen extends StatefulWidget {
  final ItemModel item;
  final Uint8List? itemImage;

  const ItemDetailScreen({
    super.key,
    required this.item,
    required this.itemImage,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "아이템 정보",
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
            },
            icon:
                Icon(Icons.star_border_outlined, color: Colors.yellow.shade700),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v130,
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            'assets/images/item${widget.item.tier}.png',
                            width: Sizes.size52,
                            height: Sizes.size52,
                          ),
                          Text(
                            "${widget.item.tier}T",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ],
                      ),
                      Gaps.h5,
                      Text(
                        widget.item.name,
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v10,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size5),
                    child: Text(
                      widget.item.info,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: FontFamily.nanumGothic,
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ),
                  Gaps.v20,
                  const ItemDetailTitle(title: '획득 방법'),
                  Gaps.v10,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var obtain in widget.item.obtain)
                          Container(
                            margin: const EdgeInsets.only(left: Sizes.size5),
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.size5,
                              horizontal: Sizes.size10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black26,
                                width: Sizes.size1,
                              ),
                              borderRadius: BorderRadius.circular(Sizes.size32),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: Sizes.size3,
                                  spreadRadius: Sizes.size1,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Text(
                              obtain,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamily.nanumGothic,
                                fontWeight: FontWeight.w700,
                                fontSize: Sizes.size14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                  if (widget.item.drop.isNotEmpty)
                    ItemDetailTitle(
                        title: '이성 효율 Top ${widget.item.drop.length} 드랍 스테이지'),
                  if (widget.item.drop.isNotEmpty)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.item.drop.length; i++)
                            EfficiencyStageRow(
                              index: i,
                              stage: widget.item.drop[i].stage,
                              efficiency: widget.item.drop[i].sanityPerItem
                                  .toStringAsFixed(2),
                            ),
                        ],
                      ),
                    ),
                  if (widget.item.drop.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                        horizontal: Sizes.size5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WrappedKoreanText(
                            '* 위에 나열된 리스트는 상시 개방 중인 스테이지의 통계 자료만 표시됩니다.',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontFamily.nanumGothic,
                              fontSize: Sizes.size12,
                            ),
                          ),
                          WrappedKoreanText(
                            '* 일반적으로 상시 개방 스테이지 보다 이벤트 개방 스테이지의 이성 효율이 더 높습니다.',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontFamily.nanumGothic,
                              fontSize: Sizes.size12,
                            ),
                          ),
                          WrappedKoreanText(
                            '* [원암 큐브 번들]과 같은 일부 아이템은 기반시설 생산을 통해 얻는 것이 더 효율적입니다.',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontFamily: FontFamily.nanumGothic,
                              fontSize: Sizes.size12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Gaps.v60,
                ],
              ),
            ),
          ),
          Stack(
            children: [
              ClipPath(
                clipper: DiagonalClipper(),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade700,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(
                  0,
                  10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: widget.item.code,
                      child: widget.itemImage != null
                          ? Image.memory(
                              widget.itemImage!,
                              width: 100,
                              height: 100,
                              gaplessPlayback: true,
                            )
                          : Image.asset(
                              'assets/images/prts.png',
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
