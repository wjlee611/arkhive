import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  const SelectButton({
    super.key,
    required this.index,
    required this.onTap,
    required this.title,
    required this.isEnd,
    required this.isSelected,
  });

  final int index;
  final Function(int) onTap;
  final String title;
  final bool isEnd;
  final bool isSelected;

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  void _onTap() {
    widget.onTap(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
          vertical: Sizes.size6,
        ),
        margin: EdgeInsets.only(
          right: widget.isEnd ? 0 : Sizes.size5,
        ),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.white : Colors.blueGrey.shade500,
          borderRadius: const BorderRadiusDirectional.vertical(
            top: Radius.circular(Sizes.size5),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.isSelected ? Colors.blueGrey.shade600 : Colors.white,
            fontSize: Sizes.size16,
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
