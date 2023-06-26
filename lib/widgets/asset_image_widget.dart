import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({
    super.key,
    required this.path,
  });

  final String path;

  /// 개발용
  Future<Image> _futureImage() async {
    return rootBundle.load(path).then((value) {
      return Image.memory(value.buffer.asUint8List());
    }).catchError((_) {
      return Image.asset(
        'assets/images/prts.png',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 릴리즈용
    // return Image.asset(path);

    /// 개발용
    return FutureBuilder(
      future: _futureImage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data as Image;
        }
        return Image.asset(
          'assets/images/prts.png',
        );
      },
    );
  }
}
