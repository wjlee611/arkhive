import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/enemy/detail/widgets/checkbox_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/diagonal_header_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/infotag_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/level_select_button_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/stat_container_widget.dart';
import 'package:arkhive/screens/enemy/detail/widgets/titletext_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnemyDetailScreen extends StatefulWidget {
  final EnemyModel enemy;
  final Uint8List? enemyImage;
  final int initLevel;

  const EnemyDetailScreen({
    super.key,
    required this.enemy,
    required this.enemyImage,
    this.initLevel = 0,
  });

  @override
  State<EnemyDetailScreen> createState() => _EnemyDetailScreenState();
}

class _EnemyDetailScreenState extends State<EnemyDetailScreen> {
  late int _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.initLevel;
  }

  void _onTapLevel(int i) {
    setState(() {
      _selectedLevel = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "적 유닛 파일",
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
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.yellow.shade700,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v130,
                  if (widget.enemy.level.length > 1)
                    LevelSelectButton(
                      selectedLevel: _selectedLevel,
                      levelLength: widget.enemy.level.length,
                      onTapLevel: _onTapLevel,
                    ),
                  widget.enemy.level.length > 1 ? Gaps.v16 : Container(),
                  const TitleText(title: "개체 이름"),
                  Gaps.v5,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size5),
                    child: Text(
                      widget.enemy.name,
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: Sizes.size16,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (widget.enemy.category != "")
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size5),
                      child: Container(
                        margin: const EdgeInsets.only(top: Sizes.size5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: Sizes.size1,
                              spreadRadius: Sizes.size1 / 10,
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: Sizes.size20,
                              width: Sizes.size5,
                              color: Colors.yellow.shade700,
                            ),
                            Container(
                              height: Sizes.size20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size10),
                              child: Center(
                                child: Text(
                                  widget.enemy.category,
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: Sizes.size12,
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Gaps.v20,
                  const TitleText(title: "개체 전투 능력"),
                  Gaps.v7,
                  InfoTag(
                    title: EnemyInfoTitle.atkType,
                    value: widget.enemy.attackType,
                  ),
                  Gaps.v6,
                  InfoTag(
                    title: EnemyInfoTitle.weightLevel,
                    value: widget.enemy.level[_selectedLevel].weight,
                  ),
                  Gaps.v2,
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(Sizes.size5),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StatContainer(
                          title: "체력",
                          stat: widget.enemy.level[_selectedLevel].hp,
                        ),
                        Gaps.h10,
                        StatContainer(
                          title: "공격력",
                          stat: widget.enemy.level[_selectedLevel].atk,
                        ),
                        Gaps.h10,
                        StatContainer(
                          title: "방어력",
                          stat: widget.enemy.level[_selectedLevel].def,
                        ),
                        Gaps.h10,
                        StatContainer(
                          title: "마법 저항",
                          stat: widget.enemy.level[_selectedLevel].res,
                        ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                  const TitleText(title: "개체 특이사항"),
                  Gaps.v7,
                  InfoTag(
                    title: EnemyInfoTitle.enemyType,
                    value: widget.enemy.enemyType,
                  ),
                  Gaps.v5,
                  CheckboxWidget(
                    title: "침묵 저항",
                    isImm: widget.enemy.level[_selectedLevel].silenceImm,
                  ),
                  Gaps.v5,
                  CheckboxWidget(
                    title: "기절 저항",
                    isImm: widget.enemy.level[_selectedLevel].stunImm,
                  ),
                  Gaps.v5,
                  if (widget.enemy.level[_selectedLevel].abilities != "")
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size4),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.blueGrey.shade600,
                              width: Sizes.size4,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: Sizes.size5),
                          child: Text(
                            widget.enemy.level[_selectedLevel].abilities,
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: Sizes.size14,
                              fontFamily: FontFamily.nanumGothic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Gaps.v60,
                ],
              ),
            ),
          ),
          DiagonalHeader(
            image: widget.enemyImage,
            code: widget.enemy.code,
          ),
        ],
      ),
    );
  }
}
