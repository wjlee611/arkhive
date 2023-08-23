import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_bloc.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_event.dart';
import 'package:arkhive/bloc/stage/stage_list_item/stage_list_item_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_zone_container.dart';
import 'package:arkhive/widgets/app_font.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageListItemBloc, StageListItemState>(
      builder: (context, state) {
        bool isOpen = state.actIsOpenMap[widget.act.actId] ?? false;
        return AnimatedPadding(
          duration: const Duration(milliseconds: 500),
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
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size10),
              boxShadow: [
                BoxShadow(
                  blurRadius: Sizes.size3,
                  color: Theme.of(context).shadowColor,
                ),
              ],
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () => _onOpenTap(context),
                  borderRadius: BorderRadius.circular(Sizes.size10),
                  child: SizedBox(
                    height: Sizes.size52,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AppFont(
                              widget.act.title,
                              fontWeight: FontWeight.w700,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 200),
                            turns: isOpen ? 0.5 : 0,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color,
                            ),
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
