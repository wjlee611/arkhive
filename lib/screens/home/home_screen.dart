import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/home/widgets/favorites_widget.dart';
import 'package:arkhive/screens/home/widgets/manual_widget.dart';
import 'package:arkhive/screens/home/widgets/prts_widget.dart';
import 'package:arkhive/screens/home/widgets/url_widget.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalData globalData = GlobalData();

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
          // physics: const BouncingScrollPhysics(
          //   parent: AlwaysScrollableScrollPhysics(),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                const PRTSWidget(),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
                    child: Row(
                      children: [
                        const UrlWidget(
                          platform: 'naver',
                          title: "공식 카페",
                          url: "https://cafe.naver.com/arknightskor",
                          color: Colors.green,
                        ),
                        Gaps.h10,
                        const UrlWidget(
                          platform: 'twitter',
                          title: "공식 트위터",
                          url: "https://twitter.com/ArknightsKorea",
                          color: Colors.blue,
                        ),
                        Gaps.h10,
                        UrlWidget(
                          platform: 'facebook',
                          title: "공식 페이스북",
                          url: "https://www.facebook.com/ArknightsKorea",
                          color: Colors.blue.shade700,
                        ),
                        Gaps.h10,
                        const UrlWidget(
                          platform: 'youtube',
                          title: "공식 유튜브",
                          url:
                              "https://www.youtube.com/channel/UCnnbUv4urnbWgb_lgGUfeBw",
                          color: Colors.red,
                        ),
                        Gaps.h10,
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
                const FavoritesWidget(),
                Gaps.v20,
                const ManualWidget(),
              ],
            ),
          ),
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
