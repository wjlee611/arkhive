import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class ModuleStageButton extends StatefulWidget {
  const ModuleStageButton({
    super.key,
    required this.index,
    required this.onModuleStageButtonTap,
    required this.title,
    required this.isSelected,
  });

  final int index;
  final Function(int) onModuleStageButtonTap;
  final String title;
  final bool isSelected;

  @override
  State<ModuleStageButton> createState() => _ModuleStageButtonState();
}

class _ModuleStageButtonState extends State<ModuleStageButton> {
  void _onTap() {
    widget.onModuleStageButtonTap(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size7,
        ),
        margin: const EdgeInsets.only(bottom: Sizes.size5),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.white : Colors.blueGrey.shade500,
          borderRadius: const BorderRadiusDirectional.horizontal(
            end: Radius.circular(Sizes.size5),
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
