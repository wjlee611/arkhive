import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/screens/stage/widgets/stage_list_container_widget.dart';
import 'package:flutter/material.dart';

class StagesContainer extends StatefulWidget {
  const StagesContainer({
    super.key,
    required this.act,
  });

  final ActivityListModel act;

  @override
  State<StagesContainer> createState() => _StagesContainerState();
}

class _StagesContainerState extends State<StagesContainer> {
  bool _isOpen = false;

  void _onOpenTap() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      padding: _isOpen
          ? const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size5,
            )
          : const EdgeInsets.symmetric(vertical: Sizes.size5),
      child: Container(
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
              onTap: _onOpenTap,
              borderRadius: BorderRadius.circular(Sizes.size10),
              child: Container(
                height: Sizes.size40,
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          if (widget.stages.nameFirst != null)
                            Text(
                              '${widget.stages.nameFirst!} - ',
                              style: const TextStyle(
                                fontFamily: FontFamily.nanumGothic,
                                fontWeight: FontWeight.w700,
                                fontSize: Sizes.size12,
                                color: Colors.black87,
                              ),
                            ),
                          Flexible(
                            child: Text(
                              widget.stages.nameSecond!,
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
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _isOpen ? 0.5 : 0,
                      child: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isOpen) StageListContainer(stages: widget.stages),
          ],
        ),
      ),
    );
  }
}
