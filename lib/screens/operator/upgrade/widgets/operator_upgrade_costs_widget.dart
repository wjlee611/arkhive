import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/common/item_cost_model.dart';
import 'package:arkhive/screens/operator/upgrade/widgets/operator_upgrade_item_btn.dart';
import 'package:flutter/material.dart';

class OperatorUpgradeCostsWidget extends StatelessWidget {
  final List<ItemCostModel> costs;

  const OperatorUpgradeCostsWidget({
    super.key,
    required this.costs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.size10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var cost in costs)
            Padding(
              padding: const EdgeInsets.only(left: Sizes.size10),
              child: OperatorUpgradeItemBtn(cost: cost),
            )
        ],
      ),
    );
  }
}
