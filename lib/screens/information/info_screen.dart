import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/information/widgets/info_container_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final GlobalData _globalData = GlobalData();

  void _tabDonate() {
    // TODO: donate function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '정보',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v20,
              Column(
                children: [
                  Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Container(
                      width: Sizes.size64,
                      height: Sizes.size64,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade700,
                            blurRadius: Sizes.size5,
                          )
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: Sizes.size60,
                          height: Sizes.size60,
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              width: Sizes.size48,
                              height: Sizes.size48,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.shade900,
                                    blurRadius: Sizes.size5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width: Sizes.size40,
                                  height: Sizes.size40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, -Sizes.size52 - Sizes.size2),
                      child: Icon(
                        Icons.hive_outlined,
                        color: Colors.yellow.shade800,
                        size: Sizes.size44,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(
                      0,
                      -Sizes.size28,
                    ),
                    child: Text(
                      'Arkhive',
                      style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontFamily: FontFamily.nanumGothic,
                          fontSize: Sizes.size36,
                          fontWeight: FontWeight.w700,
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: Sizes.size5,
                            ),
                          ]),
                    ),
                  ),
                  const InfoContainer(
                    tag: "버전",
                    info: GlobalData.appVersion,
                  ),
                  Gaps.v20,
                  InfoContainer(
                    tag: "게임 버전",
                    info: _globalData.oldVer.replaceAll('"', ''),
                  ),
                  Gaps.v20,
                  const InfoContainer(
                    tag: "개발자",
                    info: "Dev.Woong",
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: _tabDonate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size10,
                            horizontal: Sizes.size52,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.shade100,
                                blurRadius: Sizes.size5,
                              ),
                            ],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: const Text('Donate ♥️'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
