import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class PRTSWidget extends StatelessWidget {
  const PRTSWidget({super.key});

  void _onTap(BuildContext context) {
    OpenDetailScreen.onTutorialTab(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
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
                  child: AppFont("어서오세요, 박사님.\n가이드를 보시려면 여길 터치해 주십시오."),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
