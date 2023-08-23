import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
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
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: Sizes.size2,
            spreadRadius: Sizes.size1 / 10,
            color: Theme.of(context).shadowColor,
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
              child: AppFont(
                title,
                color: Theme.of(context).textTheme.labelSmall!.color,
                fontSize: Sizes.size10,
              ),
            ),
          ),
          Container(
            height: Sizes.size24,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size5),
            color: Colors.yellow.shade800,
            child: Center(
              child: AppFont(
                _textFormatter(),
                color: Colors.white,
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
