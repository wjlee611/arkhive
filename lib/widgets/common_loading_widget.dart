import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/material.dart';

class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: Sizes.size80,
          height: Sizes.size3,
          child: LinearProgressIndicator(
            color: Colors.yellow.shade800,
            backgroundColor: Colors.transparent,
          ),
        ),
        Image.asset(
          'assets/images/prts.png',
          color: Colors.grey.shade400,
          width: Sizes.size60,
          height: Sizes.size60,
        ),
      ],
    );
  }
}
