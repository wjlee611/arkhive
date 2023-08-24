import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class FavoriteSliverAppBar extends StatefulWidget {
  final Function(bool) onChanged;

  const FavoriteSliverAppBar({
    super.key,
    required this.onChanged,
  });

  @override
  State<FavoriteSliverAppBar> createState() => _FavoriteSliverAppBarState();
}

class _FavoriteSliverAppBarState extends State<FavoriteSliverAppBar> {
  bool _isEditMode = false;

  void _onChanged(bool value) {
    _isEditMode = value;
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      toolbarHeight: Sizes.size60,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.size20,
          left: Sizes.size20,
          right: Sizes.size20,
        ),
        child: Container(
          height: Sizes.size40,
          padding: const EdgeInsets.only(left: Sizes.size10),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade600,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Sizes.size10),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                color: Theme.of(context).shadowColor,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
              Row(
                children: [
                  const AppFont(
                    '편집',
                    color: Colors.white,
                  ),
                  Switch(
                    value: _isEditMode,
                    activeColor: Colors.yellow.shade700,
                    onChanged: _onChanged,
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
