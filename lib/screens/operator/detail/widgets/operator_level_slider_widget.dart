import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class OperatorLevelSlider extends StatefulWidget {
  const OperatorLevelSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.currValue,
    required this.onChange,
    required this.onChangeStart,
    required this.onChangeEnd,
  });

  final int minValue;
  final int maxValue;
  final int currValue;
  final void Function(int) onChange;
  final void Function(double) onChangeStart;
  final void Function(double) onChangeEnd;

  @override
  State<OperatorLevelSlider> createState() => _OperatorLevelSliderState();
}

class _OperatorLevelSliderState extends State<OperatorLevelSlider> {
  int _value = 1;

  void _onChange(double value) {
    if (value.toInt() != _value) {
      _value = value.toInt();
      widget.onChange(value.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: CustomThumbShape(currValue: widget.currValue),
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
        onChangeStart: widget.onChangeStart,
        onChangeEnd: widget.onChangeEnd,
      ),
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius = Sizes.size16;
  final double thumbHeight = Sizes.size32;
  int currValue = 1;

  CustomThumbShape({required this.currValue});

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

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$currValue',
        style: const TextStyle(
          fontFamily: FontFamily.nanumGothic,
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(blurRadius: Sizes.size5),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    final textCenter = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(context.canvas, textCenter);
  }
}
