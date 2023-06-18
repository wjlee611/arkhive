import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.initialValue,
    required this.onSelected,
  });

  final SortOptions initialValue;
  final Function(SortOptions) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: initialValue,
      onSelected: onSelected,
      offset: const Offset(0, 0),
      icon: Icon(
        Icons.filter_alt_rounded,
        color: Colors.yellow.shade800,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: Sizes.size5,
          color: Colors.blueGrey.shade700,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
      ),
      elevation: 0,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: SortOptions.starUp,
          child: Text(
            '레어도 오름차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const PopupMenuItem(
          value: SortOptions.starDown,
          child: Text(
            '레어도 내림차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const PopupMenuItem(
          value: SortOptions.nameUp,
          child: Text(
            '이름 오름차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const PopupMenuItem(
          value: SortOptions.nameDown,
          child: Text(
            '이름 내림차순',
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
