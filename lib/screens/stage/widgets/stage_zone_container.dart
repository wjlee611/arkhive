import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_bloc.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_list_card_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageZoneContainer extends StatefulWidget {
  const StageZoneContainer({
    super.key,
    required this.act,
  });

  final ActivityListModel act;

  @override
  State<StageZoneContainer> createState() => _StageZoneContainerState();
}

class _StageZoneContainerState extends State<StageZoneContainer>
    with TickerProviderStateMixin {
  late TabController _zoneTabController;

  @override
  void initState() {
    super.initState();
    _zoneTabController = TabController(
      length: widget.act.zones.length,
      vsync: this,
    );
    _zoneTabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _zoneTabController.removeListener(_handleTabSelection);
    _zoneTabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant StageZoneContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.act.zones.length != widget.act.zones.length) {
      _zoneTabController.removeListener(_handleTabSelection);
      _zoneTabController.dispose();

      _zoneTabController = TabController(
        length: widget.act.zones.length,
        vsync: this,
      );
      _zoneTabController.addListener(_handleTabSelection);
    }
  }

  void _handleTabSelection() {
    if (_zoneTabController.indexIsChanging) {
      setState(() {});
    }
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

  double _containerHeightCalc({
    required bool isOpen,
    required bool isTabVisible,
    required bool isTimeVisible,
    required int length,
  }) {
    if (isOpen && length > 0) {
      var height = (Sizes.size52 + Sizes.size1) * length - Sizes.size1;
      if (isTimeVisible) {
        height += Sizes.size40;
      }
      if (isTabVisible) {
        height += Sizes.size40;
      }
      return height;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageListItemBloc, StageListItemState>(
      buildWhen: (previous, current) {
        if (current is StageListItemLoadingState &&
            current.loadingActId == widget.act.actId) {
          return true;
        }
        if (current is StageListItemLoadedState &&
            current.loadedActId == widget.act.actId) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        var length = state
                .zoneToStageMap[
                    widget.act.zones[_zoneTabController.index].zoneId]
                ?.length ??
            0;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          height: state is StageListItemLoadingState
              ? Sizes.size80
              : _containerHeightCalc(
                  isOpen: state.actIsOpenMap[widget.act.actId] == true,
                  isTabVisible: widget.act.zones.length > 1,
                  isTimeVisible: widget.act.timeStamps != null,
                  length: length,
                ),
          child: _bodyBuild(
            state: state,
            length: length,
            isOpen: state.actIsOpenMap[widget.act.actId] == true,
          ),
        );
      },
    );
  }

  Widget _bodyBuild({
    required StageListItemState state,
    required int length,
    required bool isOpen,
  }) {
    if (state is StageListItemLoadingState || !isOpen) {
      return const CommonLoadingWidget();
    }
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (widget.act.timeStamps != null)
          SizedBox(
            height: Sizes.size40,
            child: Padding(
              padding: const EdgeInsets.only(right: Sizes.size20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
              ),
            ),
          ),
        if (widget.act.zones.length > 1)
          SizedBox(
            height: Sizes.size40,
            child: TabBar(
              controller: _zoneTabController,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.yellow.shade800,
                    width: Sizes.size3,
                  ),
                ),
              ),
              labelColor: Colors.yellow.shade800,
              unselectedLabelColor: Colors.black,
              tabs: [
                for (int i = 0; i < widget.act.zones.length; i++)
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(top: Sizes.size2),
                      child: Text(
                        widget.act.zones[i].title,
                        style: const TextStyle(
                          fontFamily: FontFamily.nanumGothic,
                          fontWeight: FontWeight.w700,
                          fontSize: Sizes.size12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return StageListCardWidget(
              stage: state.zoneToStageMap[
                  widget.act.zones[_zoneTabController.index].zoneId]![index],
            );
          },
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: Sizes.size1,
            color: Colors.black12,
            margin: const EdgeInsets.symmetric(horizontal: Sizes.size16),
          ),
          itemCount: length,
        ),
      ],
    );
  }
}
