import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class InfoBtn extends StatelessWidget {
  final String title;
  final Function() onTap;

  const InfoBtn({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: Sizes.size40),
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size10),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: Sizes.size5,
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Center(
          child: AppFont(
            title,
            fontSize: Sizes.size14,
          ),
        ),
      ),
    );
  }
}
