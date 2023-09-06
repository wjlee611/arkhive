import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/information/widgets/info_btn.dart';
import 'package:arkhive/screens/information/widgets/info_container_widget.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  void _tabDonate() async {
    final Uri url = Uri.parse('https://www.buymeacoffee.com/wjlee611m');

    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _tabHistory() {
    OpenDetailScreen.onHistoryTab(context: context);
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
        physics: const BouncingScrollPhysics(),
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
                  Gaps.v40,
                  InfoBtn(
                    title: 'Donate ♥️',
                    onTap: _tabDonate,
                  ),
                  Gaps.v20,
                  InfoBtn(
                    title: '패치노트 확인',
                    onTap: _tabHistory,
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
