import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/update_screen.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

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
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const UpdateScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
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
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: WrappedKoreanText(
                                "박사님, 새로운 데이터가 확인되었습니다. 여기를 누르셔서 업데이트 하실 수 있습니다.",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.nanumGothic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        const UrlWidget(
                            platform: 'naver',
                            title: "공식 카페",
                            url: "https://cafe.naver.com/arknightskor",
                            color: Colors.green),
                        const SizedBox(
                          width: 10,
                        ),
                        const UrlWidget(
                          platform: 'twitter',
                          title: "공식 트위터",
                          url: "https://twitter.com/ArknightsKorea",
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        UrlWidget(
                          platform: 'facebook',
                          title: "공식 페이스북",
                          url: "https://www.facebook.com/ArknightsKorea",
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const UrlWidget(
                          platform: 'youtube',
                          title: "공식 유튜브",
                          url:
                              "https://www.youtube.com/channel/UCnnbUv4urnbWgb_lgGUfeBw",
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const UrlWidget(
                          platform: 'ak',
                          title: "공식 사이트",
                          url: "https://www.arknights.kr/",
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
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
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "즐겨찾기",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "설명서",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
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
                            WrappedKoreanText(
                              "안녕하세요 박사님.",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            WrappedKoreanText(
                              "Arkhive 소개를 도와드릴 로도스 아일랜드 인공지능 비서 PRTS입니다.",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            WrappedKoreanText(
                              "Arkhive는 로도스 아일랜드를 비롯한 테라에 존재하는 생명체, 물건, 현상 등 거의 모든 정보를 제공하여 박사님의 업무를 도와드립니다.",
                              style: const TextStyle(
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
                                WrappedKoreanText(
                                  '최상단에 ',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.nanumGothic,
                                  ),
                                ),
                                const Icon(
                                  Icons.sort,
                                  size: 18,
                                ),
                                WrappedKoreanText(
                                  '이 보이시나요?',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.nanumGothic,
                                  ),
                                ),
                              ],
                            ),
                            WrappedKoreanText(
                              '메뉴 바를 열어 데이터베이스에 저장된 모든 자료를 열람하실 수 있습니다.',
                              style: const TextStyle(
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
                                WrappedKoreanText(
                                  '각 자료마다 상단에 ',
                                  style: const TextStyle(
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
                                WrappedKoreanText(
                                  '이 존재합니다.',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.nanumGothic,
                                  ),
                                ),
                              ],
                            ),
                            WrappedKoreanText(
                              "누르시면 앞으로 메인 화면 - 즐겨찾기 에서 빠르게 접근하실 수 있습니다.",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            WrappedKoreanText(
                              "한번 더 누르시면 즐겨찾기에서 제거됩니다.",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            WrappedKoreanText(
                              '이상 설명을 마치도록 하겠습니다.',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.nanumGothic,
                              ),
                            ),
                            WrappedKoreanText(
                              '좋은 하루 되세요, 박사님.',
                              style: const TextStyle(
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
      ),
      drawer: const NavDrawer(),
    );
  }
}

class UrlWidget extends StatelessWidget {
  const UrlWidget({
    Key? key,
    this.platform = 'browser',
    required this.url,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String platform;
  final String url;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        late final url_ = Uri.parse(url);

        // youtube launch
        String yt = url.split('//').last;
        // ignore: deprecated_member_use
        if (platform == 'youtube' && await canLaunch('youtube://$yt')) {
          // ignore: deprecated_member_use
          await launch('youtube://$yt', forceSafariVC: false);
          return;
        }

        if (await canLaunchUrl(url_)) {
          launchUrl(url_, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Icon(
              platform == "naver"
                  ? Icons.local_cafe_rounded
                  : platform == 'twitter'
                      ? FontAwesomeIcons.twitter
                      : platform == "facebook"
                          ? Icons.facebook
                          : platform == "youtube"
                              ? Icons.play_arrow
                              : Icons.grain_outlined,
              color: Colors.white,
            ),
            Text(
              " $title",
              style: const TextStyle(
                fontSize: 14,
                fontFamily: FontFamily.nanumGothic,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
