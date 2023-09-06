import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/stage/stage_list_model.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';

class StageOpenDateWidget extends StatelessWidget {
  const StageOpenDateWidget({
    super.key,
    required this.title,
    required this.timeStamp,
  });

  final String title;
  final StageTimeStampModel timeStamp;

  String _timestampToDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String year = date.year.toString().substring(2);
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');

    return '$year-$month-$day / $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size40,
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.size20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonSubTitleWidget(
              text: title,
              isShadow: false,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppFont(
                  '${_timestampToDate(timeStamp.startTime)} ~ ${_timestampToDate(timeStamp.endTime)}',
                  fontWeight: FontWeight.w700,
                ),
                AppFont(
                  '교환소 개방  ~ ${_timestampToDate(timeStamp.rewardEndTime)}',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
