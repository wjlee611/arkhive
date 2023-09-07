import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/screen.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class StackScreenListTile extends StatelessWidget {
  const StackScreenListTile({
    super.key,
    required this.screen,
  });

  final EScreen screen;

  void _onTap(BuildContext context) {
    Scaffold.of(context).closeDrawer();
    switch (screen) {
      case EScreen.setting:
        OpenDetailScreen.onSettingTab(context: context);
        return;
      case EScreen.info:
        OpenDetailScreen.onInfoTab(context: context);
        return;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        screen.icon,
        color: Colors.white,
      ),
      title: AppFont(
        screen.ko,
        color: Colors.white,
        fontSize: Sizes.size14,
      ),
      onTap: () => _onTap(context),
    );
  }
}
