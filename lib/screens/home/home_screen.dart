import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/favorite_cubit.dart';
import 'package:arkhive/screens/home/widgets/favorite_listitem_widget.dart';
import 'package:arkhive/screens/home/widgets/favorite_sliver_appbar.dart';
import 'package:arkhive/screens/home/widgets/prts_widget.dart';
import 'package:arkhive/screens/home/widgets/url_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEditMode = false;

  void _onChanged(bool value) {
    setState(() {
      _isEditMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.only(
              top: Sizes.size20,
              left: Sizes.size20,
              right: Sizes.size20,
            ),
            sliver: SliverToBoxAdapter(
              child: PRTSWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: Sizes.size20),
                child: Row(
                  children: [
                    Gaps.h20,
                    const UrlWidget(
                      platform: 'naver',
                      title: "공식 카페",
                      url: "https://cafe.naver.com/arknightskor",
                      color: Colors.green,
                    ),
                    Gaps.h10,
                    const UrlWidget(
                      platform: 'twitter',
                      title: "공식 X(트위터)",
                      url: "https://twitter.com/ArknightsKorea",
                      color: Colors.black,
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
                    Gaps.h20,
                  ],
                ),
              ),
            ),
          ),
          FavoriteSliverAppBar(onChanged: _onChanged),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            sliver: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state.favs.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: Sizes.size10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Theme.of(context).shadowColor,
                          )
                        ],
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(Sizes.size10),
                        ),
                      ),
                      child: const Center(
                        child: AppFont(
                          "즐겨찾기에 동록된 항목이 없습니다.",
                          fontSize: Sizes.size12,
                        ),
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => FavoriteListItemWidget(
                      fav: state.favs[index],
                      index: index,
                      isLast: index == state.favs.length - 1,
                      isEditMode: _isEditMode,
                    ),
                    childCount: state.favs.length,
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: Gaps.v130),
        ],
      ),
    );
  }
}
