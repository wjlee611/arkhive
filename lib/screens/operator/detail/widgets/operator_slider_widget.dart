import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/constants/font_family.dart';
import 'package:flutter/material.dart';

class OperatorSlider extends StatefulWidget {
  const OperatorSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.currValue,
    this.onChange,
    this.onChangeEnd,
    required this.tag,
  });

  final int minValue;
  final int maxValue;
  final int currValue;
  final void Function(int)? onChange;
  final void Function(int)? onChangeEnd;
  final String tag;

  @override
  State<OperatorSlider> createState() => _OperatorSliderState();
}

class _OperatorSliderState extends State<OperatorSlider> {
  int _value = 1;

  void _onChange(double value) {
    if (value.toInt() != _value) {
      _value = value.toInt();
      if (widget.onChange != null) {
        widget.onChange!(value.toInt());
      }
    }
  }

  void _onChangeEnd(double value) {
    if (widget.onChangeEnd != null) {
      widget.onChangeEnd!(value.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: CustomThumbShape(
          currValue: widget.currValue,
          tag: widget.tag,
        ),
        activeTrackColor: Colors.yellow.shade800,
        inactiveTrackColor: Colors.yellow.shade600,
        overlayColor: Colors.yellow.shade600.withOpacity(0.5),
        thumbColor: Colors.yellow.shade800,
      ),
      child: Slider(
        min: widget.minValue.toDouble(),
        max: widget.maxValue.toDouble(),
        value: widget.currValue.toDouble(),
        onChanged: _onChange,
        onChangeEnd: _onChangeEnd,
      ),
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  CustomThumbShape({required this.currValue, required this.tag});

  final double thumbRadius = Sizes.size16;
  final double thumbHeight = Sizes.size32;
  final int currValue;
  final String tag;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbHeight, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final thumbPaint = Paint()..color = sliderTheme!.thumbColor!;
    final thumbPath = Path()
      ..moveTo(center.dx - thumbRadius, center.dy)
      ..lineTo(center.dx, center.dy + thumbRadius)
      ..lineTo(center.dx + thumbRadius, center.dy)
      ..lineTo(center.dx, center.dy - thumbRadius)
      ..close();
    context.canvas.drawPath(thumbPath, thumbPaint);

    final valueTextPainter = TextPainter(
      text: TextSpan(
        text: '${currValue > 100 ? 100 + (currValue - 100) * 10 : currValue}',
        style: const TextStyle(
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [
            Shadow(blurRadius: Sizes.size5),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    valueTextPainter.layout();
    final valueTextCenter = Offset(
      center.dx - valueTextPainter.width / 2,
      center.dy - valueTextPainter.height / 2,
    );
    valueTextPainter.paint(context.canvas, valueTextCenter);

    final levelTextPainter = TextPainter(
      text: TextSpan(
        text: tag,
        style: const TextStyle(
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [
            Shadow(blurRadius: Sizes.size14),
            Shadow(blurRadius: Sizes.size2),
            Shadow(blurRadius: Sizes.size2),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    levelTextPainter.layout();
    final levelTextOffset = Offset(
      center.dx - levelTextPainter.width / 2,
      center.dy - levelTextPainter.height / 2 + Sizes.size16,
    );
    levelTextPainter.paint(context.canvas, levelTextOffset);
  }
}
