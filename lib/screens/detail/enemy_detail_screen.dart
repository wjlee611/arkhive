import 'package:arkhive/models/enemy_model.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class EnemyDetailScreen extends StatefulWidget {
  final EnemyModel enemy;

  const EnemyDetailScreen({
    super.key,
    required this.enemy,
  });

  @override
  State<EnemyDetailScreen> createState() => _EnemyDetailScreenState();
}

class _EnemyDetailScreenState extends State<EnemyDetailScreen> {
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
                  const TitleText(title: "개체 이름"),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.enemy.name,
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: 18,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleText(title: "개체 전투 능력"),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0.1,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 22,
                            width: 70,
                            child: Center(
                              child: Text(
                                "공격 방식",
                                style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 10,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 22,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            color:
                                widget.enemy.attackType == EnemyAtkType.noAttack
                                    ? Colors.blueGrey.shade600
                                    : widget.enemy.attackType.contains('아츠')
                                        ? Colors.redAccent
                                        : Colors.blueAccent,
                            child: Center(
                              child: Text(
                                widget.enemy.attackType,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(5),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StatContainer(
                          title: "체력",
                          stat: widget.enemy.hp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        StatContainer(
                          title: "공격력",
                          stat: widget.enemy.atk,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        StatContainer(
                          title: "방어력",
                          stat: widget.enemy.def,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        StatContainer(
                          title: "마법 저항",
                          stat: widget.enemy.res,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleText(title: "개체 특이사항"),
                  const SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 0.1,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 22,
                            width: 90,
                            child: Center(
                              child: Text(
                                "위험 분류등급",
                                style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 10,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 22,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            color: widget.enemy.enemyType == EnemyType.elite
                                ? Colors.deepOrange
                                : widget.enemy.enemyType == EnemyType.boss
                                    ? Colors.purple
                                    : Colors.blueGrey.shade600,
                            child: Center(
                              child: Text(
                                widget.enemy.enemyType,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
                  const SizedBox(
                    height: 5,
                  ),
                  CheckboxWidget(
                    title: "침묵 저항",
                    isImm: widget.enemy.silenceImm,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CheckboxWidget(
                    title: "기절 저항",
                    isImm: widget.enemy.stunImm,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.enemy.abilities != ""
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.blueGrey.shade600,
                                  width: 4,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                widget.enemy.abilities,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade800,
                                  fontSize: 14,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 50,
                  ),
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
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: widget.enemy.code,
                        child: Image.asset(
                          'assets/images/enemies/${widget.enemy.code}.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Transform.rotate(
                          angle: 45 * math.pi / 180,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                            ),
                            child: Container(),
                          ),
                        ),
                        Text(
                          widget.enemy.code.replaceAll('_', ''),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              const Shadow(
                                blurRadius: 15,
                              ),
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    Key? key,
    required this.title,
    required this.isImm,
  }) : super(key: key);

  final String title;
  final bool isImm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 90,
        decoration: BoxDecoration(
          color: isImm ? Colors.yellow.shade800 : Colors.black38,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0.1,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 4),
            Icon(
              isImm ? Icons.check : Icons.close,
              color: Colors.white,
            ),
            Flexible(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 3,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade600,
      ),
      child: Text(
        '// $title',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class StatContainer extends StatelessWidget {
  const StatContainer({
    Key? key,
    required this.title,
    required this.stat,
  }) : super(key: key);

  final String title;
  final String stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.1,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 20,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      fontSize: 10,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 4, 4),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  stat.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => "${m[1]},"),
                  style: TextStyle(
                    color: Colors.blueGrey.shade800,
                    fontSize: 13,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // 대각선이 끊어지는 부분 수정가능
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DiagonalClipper oldClipper) => false;
}
