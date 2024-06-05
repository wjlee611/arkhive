import 'package:flutter/widgets.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  final String path;
  final double? width, height;
  final BoxFit? fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('[MISSING IMAGE] $path');
        return Image.asset(
          'assets/images/prts.png',
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
        );
      },
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }
}
