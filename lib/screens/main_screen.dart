import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Arkhive',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
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
                      color: Colors.blueGrey.shade600,
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        'assets/images/prts.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "어서오세요, 박사님.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
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
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade700,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "즐겨찾기",
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
                    const Padding(
                      padding: EdgeInsets.all(10),
                      // TODO: 즐겨찾기 저장 시: 카테고리,사진이름,이름
                      // 즐겨찾기 불러올 시: split후, [1], [2]로 아이콘 추가
                      // 즐겨찾기 클릭 시: [0]에서 [2]이름 탐색 후 [0]에 맟는 화면 띄워주기
                      child: Text(
                        "즐겨찾기에 동록된 항목이 없습니다.",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: FontFamily.nanumGothic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
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
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: Colors.yellow.shade700,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "설명서",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "안녕하세요 박사님.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const Text(
                            "Arkhive 소개를 도와드릴 로도스 아일랜드 인공지능 비서 PRTS입니다.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Arkhive는 로도스 아일랜드를 비롯한 테라에 존재하는 생명체, 물건, 현상 등 거의 모든 정보를 제공하여 박사님의 업무를 도와드립니다.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '최상단에 ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                              Icon(
                                Icons.sort,
                                size: 18,
                              ),
                              Text(
                                '이 보이시나요?',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '메뉴 바를 열어 데이터베이스에 저장된 모든 자료를 열람하실 수 있습니다.',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '각 자료마다 상단에 ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                              Icon(
                                Icons.star_border_outlined,
                                color: Colors.yellow.shade700,
                                size: 18,
                              ),
                              const Text(
                                '이 존재합니다.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "누르시면 앞으로 메인 화면 - 즐겨찾기 에서 빠르게 접근하실 수 있습니다.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const Text(
                            "한번 더 누르시면 즐겨찾기에서 제거됩니다.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            '이상 설명을 마치도록 하겠습니다.',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
                          ),
                          const Text(
                            '좋은 하루 되세요, 박사님.',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: FontFamily.nanumGothic,
                            ),
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
      drawer: const NavDrawer(),
    );
  }
}
