import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class AppFont extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final List<Shadow>? shadows;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppFont(
    this.text, {
    super.key,
    this.color,
    this.fontSize = Sizes.size12,
    this.fontWeight = FontWeight.w400,
    this.fontStyle,
    this.shadows,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontFamily: FontFamily.nanumGothic,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
      ),
    );
  }
}
