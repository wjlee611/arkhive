import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/global_data.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/screens/operator/widgets/limited_banner_widget.dart';
import 'package:arkhive/tools/load_image_from_securestorage.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:flutter/material.dart';

class OperatorClassListView extends StatefulWidget {
  const OperatorClassListView({
    super.key,
    required this.classIdx,
    required this.isOpen,
  });

  final int classIdx;
  final bool isOpen;

  @override
  State<OperatorClassListView> createState() => _OperatorClassListViewState();
}

class _OperatorClassListViewState extends State<OperatorClassListView> {
  GlobalData globalData = GlobalData();

  void _onOperatorTap(int index) {
    OpenDetailScreen.onOperatorTab(
      classedList: globalData.classedOperators[widget.classIdx],
      name: globalData.classedOperators[widget.classIdx][index].name,
      opImage: getImageFromSP(
          "operator/${globalData.classedOperators[widget.classIdx][index].imageName}"),
      context: context,
    );
  }

  Color _rarityBarColorSelector(int rare) {
    if (rare == 6) return Colors.white;
    if (rare == 5) return Colors.yellow.shade700;
    return Colors.grey.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final OperatorModel oper =
              globalData.classedOperators[widget.classIdx][index];
          return GestureDetector(
            onTap: () => _onOperatorTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
              ),
              child: FutureBuilder(
                future: getImageFromSP("operator/${oper.imageName}"),
                builder: (context, snapshot) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Sizes.size52,
                        width: Sizes.size5,
                        decoration: BoxDecoration(
                          color: _rarityBarColorSelector(int.parse(oper.rare)),
                        ),
                      ),
                      Hero(
                        tag: oper.imageName,
                        child: Container(
                          width: Sizes.size52,
                          height: Sizes.size52,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: snapshot.hasData
                              ? Image.memory(
                                  snapshot.data!,
                                  width: Sizes.size52,
                                  height: Sizes.size52,
                                  gaplessPlayback: true,
                                )
                              : Image.asset(
                                  "assets/images/prts.png",
                                  width: Sizes.size52,
                                  height: Sizes.size52,
                                ),
                        ),
                      ),
                      Gaps.h20,
                      Flexible(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                oper.name
                                    .replaceAll(" (한정)", "")
                                    .replaceAll(" [한정]", ""),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: Sizes.size14,
                                  fontFamily: FontFamily.nanumGothic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (oper.name.contains("(한정)") ||
                                oper.name.contains("[한정]"))
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: Sizes.size10,
                                  right: Sizes.size20,
                                ),
                                child: LimitedBanner(
                                  name: oper.name,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
        childCount: widget.isOpen
            ? globalData.classedOperators[widget.classIdx].length
            : 0,
      ),
    );
  }
}
