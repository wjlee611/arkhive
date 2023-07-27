import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';

class PRTSWidget extends StatefulWidget {
  const PRTSWidget({super.key});

  @override
  State<PRTSWidget> createState() => _PRTSWidgetState();
}

class _PRTSWidgetState extends State<PRTSWidget> {
  @override
  void initState() {
    super.initState();

    // Version check once
    // context.read<VersionCheckBloc>().add(const VersionCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size10),
                  child: Text(
                    "어서오세요, 박사님.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
    );
  }
}
