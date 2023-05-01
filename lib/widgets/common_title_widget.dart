import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class CommonTitleWidget extends StatelessWidget {
  const CommonTitleWidget({
    super.key,
    required this.text,
    this.color = const Color(0xFF546E7A),
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        Sizes.size10,
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          Sizes.size10,
        ),
        child: Container(
          width: double.infinity,
          height: Sizes.size40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.3),
                Colors.white.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              top: BorderSide(
                color: color,
                width: Sizes.size3,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v5,
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.nanumGothic,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    const Shadow(
                      blurRadius: Sizes.size10,
                    ),
                    Shadow(
                      blurRadius: Sizes.size5,
                      color: color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonSubTitleWidget extends StatelessWidget {
  const CommonSubTitleWidget({
    super.key,
    required this.text,
    this.color = const Color(0xFFF9A825),
    this.size = Sizes.size12,
    this.isShadow = true,
  });

  final String text;
  final Color color;
  final double size;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              if (isShadow)
                BoxShadow(
                  blurRadius: Sizes.size1,
                  spreadRadius: Sizes.size1,
                  color: Colors.black.withOpacity(0.2),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: Sizes.size3,
                height: Sizes.size20,
                decoration: BoxDecoration(
                  color: color,
                ),
              ),
              Gaps.h5,
              Text(
                text,
                style: TextStyle(
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                  fontSize: size,
                  color: Colors.black,
                ),
              ),
              Gaps.h5,
            ],
          ),
        ),
      ],
    );
  }
}
