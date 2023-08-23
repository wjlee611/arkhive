import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppFont extends StatelessWidget {
  final String text;
  final bool forceColorNull;
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
    this.forceColorNull = false,
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
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) => Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          color: forceColorNull
              ? null
              : color ?? Theme.of(context).textTheme.bodySmall!.color,
          fontFamily: FontFamily.nanumGothic,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          shadows: shadows,
        ),
      ),
    );
  }
}
