import 'package:arkhive/constants/gaps.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppFont(
                    '데이터베이스 지역',
                    fontSize: Sizes.size14,
                  ),
                  Gaps.h10,
                  Flexible(
                    child: Container(
                      height: Sizes.size1,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                  Gaps.h10,
                  const SettingDBRegionWidget(),
                ],
              ),
              Gaps.v3,
              AppFont(
                '* 위 설정 변경시 메인 화면으로 돌아가게 됩니다.',
                color: Theme.of(context).textTheme.labelSmall!.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
