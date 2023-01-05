import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorDetailScreen extends StatefulWidget {
  final OperatorModel operator_;

  const OperatorDetailScreen({
    super.key,
    required this.operator_,
  });

  @override
  State<OperatorDetailScreen> createState() => _OperatorDetailScreenState();
}

class _OperatorDetailScreenState extends State<OperatorDetailScreen> {
  String _getPostionInfo(String position) {
    if (position == "전술가") return OperatorModel.tactician;
    if (position == "돌격수") return OperatorModel.charger;
    if (position == "척후병") return OperatorModel.pioneer;
    if (position == "기수") return OperatorModel.standardBearer;

    if (position == "명사수") return OperatorModel.marksman;
    if (position == "명사수*") return OperatorModel.marksman_1star;
    if (position == "포격사수") return OperatorModel.artilleryman;
    if (position == "저격수") return OperatorModel.deadeye;
    if (position == "헤비슈터") return OperatorModel.heavyshooter;
    if (position == "산탄사수") return OperatorModel.spreadshooter;
    if (position == "공성사수") return OperatorModel.besieger;
    if (position == "투척수") return OperatorModel.flinger;

    return "not found";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "이력서",
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
            onPressed: () {},
            icon:
                Icon(Icons.star_border_outlined, color: Colors.yellow.shade700),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey.shade700,
            child: Container(
              margin: const EdgeInsets.only(
                top: 50,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(
                    50,
                  ),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.operator_.name,
                        style: TextStyle(
                          color: Colors.blueGrey.shade700,
                          fontSize: 20,
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          widget.operator_.class_ == OperatorModel.vanguard
                              ? "assets/images/class_vanguard.png"
                              : widget.operator_.class_ == OperatorModel.sniper
                                  ? "assets/images/class_sniper.png"
                                  : widget.operator_.class_ ==
                                          OperatorModel.guard
                                      ? "assets/images/class_guard.png"
                                      : widget.operator_.class_ ==
                                              OperatorModel.caster
                                          ? "assets/images/class_caster.png"
                                          : widget.operator_.class_ ==
                                                  OperatorModel.defender
                                              ? "assets/images/class_defender.png"
                                              : widget.operator_.class_ ==
                                                      OperatorModel.medic
                                                  ? "assets/images/class_medic.png"
                                                  : widget.operator_.class_ ==
                                                          OperatorModel
                                                              .specialist
                                                      ? "assets/images/class_specialist.png"
                                                      : "assets/images/class_supporter.png",
                          width: 40,
                          height: 40,
                          color: Colors.blueGrey.shade700,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.operator_.position,
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 20,
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade100,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blueGrey.shade600,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.accessibility_new_rounded,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "특성",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _getPostionInfo(widget.operator_.position),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.shade100,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.blueGrey.shade600,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.auto_awesome_rounded,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "재능",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var talent in widget.operator_.talent)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blueGrey.shade600,
                                      ),
                                      child: Text(
                                        talent.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: FontFamily.nanumGothic,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      talent.info,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: FontFamily.nanumGothic,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ImageWithStars(widget: widget),
        ],
      ),
    );
  }
}

class ImageWithStars extends StatelessWidget {
  const ImageWithStars({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OperatorDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: widget.operator_.imageName,
          child: Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              border: Border.all(
                width: 3,
                color: Colors.blueGrey.shade700,
                strokeAlign: StrokeAlign.outside,
              ),
              borderRadius: BorderRadius.circular(55),
            ),
            child: Image.asset(
              'assets/images/operators/${widget.operator_.imageName}.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(
            0,
            -10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < int.parse(widget.operator_.rare); i++)
                SizedBox(
                  width: 20,
                  child: Transform.rotate(
                    angle: 15 * math.pi / 180,
                    child: Icon(
                      Icons.star,
                      color: Colors.yellow.shade100,
                      size: 26,
                      shadows: const [
                        Shadow(blurRadius: 10),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
