import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/common/item_cost_model.dart';
import 'package:arkhive/models/item_list_model.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorUpgradeItemBtn extends StatefulWidget {
  final ItemCostModel cost;

  const OperatorUpgradeItemBtn({
    super.key,
    required this.cost,
  });

  @override
  State<OperatorUpgradeItemBtn> createState() => _OperatorUpgradeItemBtnState();
}

class _OperatorUpgradeItemBtnState extends State<OperatorUpgradeItemBtn> {
  late ItemListModel item;

  @override
  void initState() {
    super.initState();

    var items = context.read<ItemListBloc>().state.itemList;
    item = items!.firstWhere((item) => item.itemId == widget.cost.id);
  }

  void _onTap() {
    OpenDetailScreen.onItemTab(
      itemKey: item.itemId,
      iconId: item.iconId,
      name: item.name,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          AssetImageWidget(
            path: 'assets/images/item/${item.iconId}.png',
            height: Sizes.size64,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size3,
            ),
            decoration: BoxDecoration(
              color: Colors.yellow.shade800,
              borderRadius: BorderRadius.circular(Sizes.size3),
            ),
            child: AppFont(
              widget.cost.count.toString().replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => "${m[1]},"),
              color: Colors.white,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: Sizes.size2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
