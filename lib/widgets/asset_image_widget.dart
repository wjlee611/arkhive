import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AssetImageWidget extends StatelessWidget {
  static bool isDevMode = false;

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

  /// 개발용
  Future<Image> _futureImage() async {
    try {
      final value = await rootBundle.load(path);
      return Image.memory(
        value.buffer.asUint8List(),
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );
    } catch (_) {
      return Image.asset(
        'assets/images/prts.png',
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 개발용
    if (isDevMode) {
      return FutureBuilder(
        future: _futureImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data as Image;
          }
          return Image.asset(
            'assets/images/prts.png',
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
          );
        },
      );
    }

    /// 릴리즈용
    return Image.asset(
      path,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/prts.png',
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      ),
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }
}
