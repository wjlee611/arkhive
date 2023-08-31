import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/settings/widgets/setting_db_region_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppFont(
          '설정',
          color: Colors.white,
          fontSize: Sizes.size16,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                AppFont('데이터베이스 지역'),
                SettingDBRegionWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
