import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/tools/diagonal_clipper.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';

class ItemHeader extends StatelessWidget {
  const ItemHeader({
    super.key,
    required this.iconId,
  });

  final String iconId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: DiagonalClipper(),
          child: Container(
            height: Sizes.size72,
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
                  borderRadius: BorderRadius.circular(Sizes.size48),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: Sizes.size5,
                      spreadRadius: Sizes.size1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Hero(
                  tag: iconId,
                  child: AssetImageWidget(
                    path: 'assets/images/item/$iconId.png',
                    width: Sizes.size96,
                    height: Sizes.size96,
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
