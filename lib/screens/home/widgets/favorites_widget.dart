import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/favorite_cubit.dart';
import 'package:arkhive/screens/home/widgets/favorite_listitem_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.all(Sizes.size10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                  size: Sizes.size20,
                ),
                Gaps.h5,
                const AppFont(
                  "즐겨찾기",
                  color: Colors.white,
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state.favs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(Sizes.size10),
                  child: AppFont(
                    "즐겨찾기에 동록된 항목이 없습니다.",
                    fontSize: Sizes.size12,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => FavoriteListItemWidget(
                  fav: state.favs[index],
                  index: index,
                ),
                itemCount: state.favs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
