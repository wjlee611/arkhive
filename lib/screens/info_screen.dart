import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  void tabDonate() {
    print('donate');
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade700,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.shade900,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 40,
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
                      offset: const Offset(0, -55),
                      child: Icon(
                        Icons.hive_outlined,
                        color: Colors.yellow.shade800,
                        size: 45,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(
                      0,
                      -30,
                    ),
                    child: Text(
                      'Arkhive',
                      style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontFamily: FontFamily.nanumGothic,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          shadows: const [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 5,
                            ),
                          ]),
                    ),
                  ),
                  const InfoContainer(
                    tag: "버전",
                    info: "1.0.0",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const InfoContainer(
                    tag: "게임 버전",
                    info: "13.0.01(89)_22.12.27",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const InfoContainer(
                    tag: "개발자",
                    info: "Dev.Woong",
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: tabDonate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 50,
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

class InfoContainer extends StatelessWidget {
  final String tag, info;

  const InfoContainer({
    super.key,
    required this.tag,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          Container(
            width: 120,
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Center(
              child: Text(
                tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  info,
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontSize: 14,
                    fontFamily: FontFamily.nanumGothic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
