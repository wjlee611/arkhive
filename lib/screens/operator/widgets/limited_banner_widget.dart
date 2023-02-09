import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class LimitedBanner extends StatefulWidget {
  const LimitedBanner({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<LimitedBanner> createState() => _LimitedBannerState();
}

class _LimitedBannerState extends State<LimitedBanner> {
  final List<double> _stops = [
    0.1,
    0.3,
    0.5,
    0.7,
    0.9,
  ];
  final List<Color> _blue = [
    Colors.blueAccent.withOpacity(0.5),
    Colors.yellow.withOpacity(0.5),
    Colors.white.withOpacity(0),
    Colors.teal.withOpacity(0.5),
    Colors.blueAccent.withOpacity(0.5),
  ];
  final List<Color> _red = [
    Colors.yellow.withOpacity(0.5),
    Colors.redAccent.withOpacity(0.5),
    Colors.white.withOpacity(0),
    Colors.orange.withOpacity(0.5),
    Colors.redAccent.withOpacity(0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size7,
        vertical: Sizes.size3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size5),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: _stops,
          colors: widget.name.contains("(한정)") ? _blue : _red,
        ),
      ),
      child: Text(
        widget.name.contains("(한정)") ? "한정" : "콜라보 한정",
        style: TextStyle(
          color: Colors.white,
          fontSize: Sizes.size14,
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
          shadows: [
            const Shadow(
              blurRadius: Sizes.size10,
            ),
            Shadow(
              blurRadius: Sizes.size7,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
