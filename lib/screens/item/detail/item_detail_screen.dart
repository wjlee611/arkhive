import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  Text(widget.item.name),
                  Text("${widget.item.tier}티어"),
                  Text(widget.item.info),
                  const Text("획득 방법"),
                  for (var obtain in widget.item.obtain) Text(obtain),
                  widget.item.drop.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '이성 효율 Top ${widget.item.drop.length} 드랍 스테이지'),
                            Row(
                              children: const [
                                Text("스테이지"),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("이성/1개"),
                              ],
                            ),
                            for (var stage in widget.item.drop)
                              Row(
                                children: [
                                  Text(stage.stage),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(stage.sanityPerItem.toStringAsFixed(2)),
                                ],
                              ),
                          ],
                        )
                      : Container(),
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
