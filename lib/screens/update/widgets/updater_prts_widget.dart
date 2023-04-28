import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class UpdaterPRTS extends StatelessWidget {
  const UpdaterPRTS({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade100,
                blurRadius: Sizes.size5,
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Container(
                color: Colors.blueGrey.shade600,
                padding: const EdgeInsets.all(Sizes.size5),
                child: Image.asset(
                  'assets/images/prts.png',
                  width: Sizes.size48,
                  height: Sizes.size48,
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size10),
                    child: Text(
                      text,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: Sizes.size12,
                        fontFamily: FontFamily.nanumGothic,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
