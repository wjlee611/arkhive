import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class SanityInfoTag extends StatelessWidget {
  const SanityInfoTag({
    super.key,
    required this.title,
    required this.value,
    this.isFormatting,
    this.unit,
  });

  final String title;
  final int value;
  final bool? isFormatting;
  final String? unit;

  String _textFormatter() {
    if (isFormatting == true) {
      return '${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}${unit != null ? ' $unit' : ''}';
    }
    return '${value == -1 ? 'N/A' : value.toString()}${unit != null ? ' $unit' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size14),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.blueGrey.shade800,
                  fontSize: Sizes.size10,
                  fontFamily: FontFamily.nanumGothic,
                ),
              ),
            ),
          ),
          Container(
            height: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
            color: Colors.yellow.shade800,
            child: Center(
              child: Text(
                _textFormatter(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size14,
                  fontFamily: FontFamily.nanumGothic,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
