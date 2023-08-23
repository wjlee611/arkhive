import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/information/widgets/info_container_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  void _tabDonate() {
    // TODO: donate function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppFont(
          '정보',
          color: Colors.white,
          fontSize: Sizes.size16,
          fontWeight: FontWeight.w700,
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
                    child: AppFont(
                      'Arkhive',
                      color: Colors.yellow.shade700,
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.w700,
                      shadows: const [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: Sizes.size5,
                        ),
                      ],
                    ),
                  ),
                  const InfoContainer(
                    tag: "버전",
                    info: AppData.version,
                  ),
                  Gaps.v20,
                  const InfoContainer(
                    tag: "게임 버전",
                    info: AppData.gameVersion,
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
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).shadowColor,
                                blurRadius: Sizes.size5,
                              ),
                            ],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: const AppFont(
                            'Donate ♥️',
                            fontSize: Sizes.size14,
                          ),
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
