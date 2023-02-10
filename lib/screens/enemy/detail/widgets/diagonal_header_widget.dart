import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DiagonalHeader extends StatelessWidget {
  const DiagonalHeader({
    Key? key,
    this.image,
    required this.code,
  }) : super(key: key);

  final Uint8List? image;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: DiagonalClipper(),
          child: Container(
            height: Sizes.size96,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(
            0,
            Sizes.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: Sizes.size5,
                      spreadRadius: Sizes.size1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Hero(
                  tag: code,
                  child: image != null
                      ? Image.memory(
                          image!,
                          width: Sizes.size96,
                          height: Sizes.size96,
                          gaplessPlayback: true,
                        )
                      : Image.asset(
                          'assets/images/prts.png',
                          width: Sizes.size96,
                          height: Sizes.size96,
                        ),
                ),
              ),
              Gaps.h28,
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Transform.rotate(
                    angle: 45 * math.pi / 180,
                    child: Container(
                      width: Sizes.size52,
                      height: Sizes.size52,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white,
                          width: Sizes.size4,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: Sizes.size5,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Container(),
                    ),
                  ),
                  Text(
                    code.replaceAll('_', ''),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                      fontFamily: FontFamily.nanumGothic,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        const Shadow(
                          blurRadius: Sizes.size16,
                        ),
                        Shadow(
                          blurRadius: Sizes.size10,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
