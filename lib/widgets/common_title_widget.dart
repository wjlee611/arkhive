import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
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
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: Sizes.size40),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Sizes.size10),
        ),
        gradient: LinearGradient(
          colors: [
            color,
            Theme.of(context).scaffoldBackgroundColor,
          ],
          stops: const [
            0,
            0.7,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gaps.v5,
          AppFont(
            text,
            color: Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
            shadows: [
              const Shadow(
                blurRadius: Sizes.size20,
              ),
              Shadow(
                blurRadius: Sizes.size14,
                color: color,
              ),
              Shadow(
                blurRadius: Sizes.size10,
                color: color,
              ),
              Shadow(
                blurRadius: Sizes.size10,
                color: color,
              ),
            ],
          ),
        ],
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
            color:
                isShadow ? Theme.of(context).primaryColor : Colors.transparent,
            boxShadow: [
              if (isShadow)
                BoxShadow(
                  blurRadius: Sizes.size1,
                  spreadRadius: Sizes.size1,
                  color: Theme.of(context).shadowColor,
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: Sizes.size3,
                height: Sizes.size20,
                color: color,
              ),
              Gaps.h5,
              AppFont(
                text,
                fontSize: size,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodySmall!.color,
              ),
              Gaps.h5,
            ],
          ),
        ),
      ],
    );
  }
}
