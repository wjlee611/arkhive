import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class StatContainer extends StatelessWidget {
  const StatContainer({
    super.key,
    required this.title,
    required this.stat,
    required this.statRank,
  });

  final String title, stat, statRank;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.size72,
      height: Sizes.size72,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size2,
            spreadRadius: Sizes.size1 / 10,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: Sizes.size20,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      fontSize: Sizes.size10,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: Sizes.size4,
                right: Sizes.size4,
                bottom: Sizes.size4,
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Sizes.size3),
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      statRank,
                      style: TextStyle(
                        color: Colors.blueGrey.shade800.withOpacity(0.2),
                        fontSize: Sizes.size32,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      stat.replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => "${m[1]},"),
                      style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: Sizes.size12,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
