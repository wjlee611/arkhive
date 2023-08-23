import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final String tag, info;

  const InfoContainer({
    super.key,
    required this.tag,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade100,
            blurRadius: Sizes.size5,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(
            width: Sizes.size96 + Sizes.size20,
            color: Colors.blueGrey.shade600,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size20,
            ),
            child: Center(
              child: AppFont(
                tag,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFont(
                  info,
                  color: Colors.blueGrey.shade700,
                  fontSize: Sizes.size14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
