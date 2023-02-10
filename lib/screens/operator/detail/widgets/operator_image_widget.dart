import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OperatorImage extends StatelessWidget {
  const OperatorImage({
    super.key,
    required this.imageNameTag,
    required this.opImage,
  });

  final String imageNameTag;
  final Uint8List? opImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: imageNameTag,
          child: Transform.scale(
            scale: 0.6,
            child: Transform.rotate(
              angle: 45 * math.pi / 180,
              child: Container(
                width: Sizes.size96,
                height: Sizes.size96,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: Sizes.size5,
                      spreadRadius: Sizes.size4,
                    ),
                  ],
                  border: Border.all(
                    width: Sizes.size3,
                    color: Colors.blueGrey.shade600,
                    strokeAlign: StrokeAlign.outside,
                  ),
                ),
                child: Transform.scale(
                  scale: 1.4,
                  child: Transform.rotate(
                    angle: -45 * math.pi / 180,
                    child: opImage != null
                        ? Image.memory(
                            opImage!,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
