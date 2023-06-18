import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.title,
    required this.isImm,
  });

  final String title;
  final bool isImm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size4),
      child: Container(
        width: Sizes.size96,
        decoration: BoxDecoration(
          color: isImm ? Colors.yellow.shade700 : Colors.black38,
          boxShadow: [
            BoxShadow(
              blurRadius: Sizes.size2,
              spreadRadius: Sizes.size1 / 10,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gaps.h4,
            Icon(
              isImm ? Icons.check : Icons.close,
              color: Colors.white,
            ),
            Flexible(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: Sizes.size12,
                    fontFamily: FontFamily.nanumGothic,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
