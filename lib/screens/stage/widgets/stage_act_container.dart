import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_bloc.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_event.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_zone_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageActContainer extends StatefulWidget {
  const StageActContainer({
    super.key,
    required this.act,
  });

  final ActivityListModel act;

  @override
  State<StageActContainer> createState() => _StageActContainerState();
}

class _StageActContainerState extends State<StageActContainer> {
  void _onOpenTap(BuildContext context) {
    setState(() {
      context.read<StageListItemBloc>().add(StageListItemOnTabEvent(
            actId: widget.act.actId,
            zones: widget.act.zones,
          ));
    });
  }

  String _timestampToDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String year = date.year.toString().substring(2);
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageListItemBloc, StageListItemState>(
      builder: (context, state) {
        bool isOpen = state.actIsOpenMap[widget.act.actId] ?? false;
        return AnimatedPadding(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          padding: isOpen
              ? const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                  horizontal: Sizes.size5,
                )
              : const EdgeInsets.symmetric(vertical: Sizes.size5),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
              boxShadow: [
                BoxShadow(
                  blurRadius: Sizes.size1,
                  blurStyle: BlurStyle.outer,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () => _onOpenTap(context),
                  borderRadius: BorderRadius.circular(Sizes.size10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn,
                    height: widget.act.timeStamps != null
                        ? isOpen
                            ? Sizes.size80
                            : Sizes.size40
                        : Sizes.size40,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size20),
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: Sizes.size40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.act.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.nanumGothic,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Sizes.size12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                AnimatedRotation(
                                  duration: const Duration(milliseconds: 200),
                                  turns: isOpen ? 0.5 : 0,
                                  child: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.act.timeStamps != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Gaps.v3,
                                Text(
                                  '${_timestampToDate(widget.act.timeStamps!.startTime)} ~ ${_timestampToDate(widget.act.timeStamps!.endTime)}',
                                  style: const TextStyle(
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Sizes.size12,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  '이벤트 교환소: ~ ${_timestampToDate(widget.act.timeStamps!.rewardEndTime)}',
                                  style: const TextStyle(
                                    fontFamily: FontFamily.nanumGothic,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Sizes.size12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                StageZoneContainer(act: widget.act),
              ],
            ),
          ),
        );
      },
    );
  }
}
