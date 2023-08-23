import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_bloc.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_list_card_widget.dart';
import 'package:arkhive/screens/stage/widgets/stage_open_date_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
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

  double _containerHeightCalc({
    required bool isOpen,
    required bool isTabVisible,
    required int tsLength,
    required int length,
  }) {
    double height = 0;
    if (!isOpen) {
      return height;
    }
    if (length > 0) {
      height = (Sizes.size52 + Sizes.size1) * length - Sizes.size1;
    }
    height += Sizes.size40 * tsLength;
    if (isTabVisible) {
      height += Sizes.size40;
    }
    return height;
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
                  tsLength: widget.act.timeStamps.length,
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
        for (var ts in widget.act.timeStamps)
          StageOpenDateWidget(
            title: widget.act.timeStamps.indexOf(ts) > 0 ? '재개방' : '',
            timeStamp: ts,
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
              unselectedLabelColor:
                  Theme.of(context).textTheme.bodySmall!.color,
              tabs: [
                for (int i = 0; i < widget.act.zones.length; i++)
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(top: Sizes.size2),
                      child: AppFont(
                        widget.act.zones[i].title,
                        forceColorNull: true,
                        fontWeight: FontWeight.w700,
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
            color: Theme.of(context).shadowColor.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(horizontal: Sizes.size16),
          ),
          itemCount: length,
        ),
      ],
    );
  }
}
