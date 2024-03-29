import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/operator/detail/operator_modules/widgets/operator_module_info_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:arkhive/models/operator/module_model.dart';

class OperatorModuleSelectWidget extends StatefulWidget {
  const OperatorModuleSelectWidget({
    super.key,
    required this.modules,
  });

  final List<ModuleModel> modules;

  @override
  State<OperatorModuleSelectWidget> createState() =>
      _OperatorModuleSelectWidgetState();
}

class _OperatorModuleSelectWidgetState extends State<OperatorModuleSelectWidget>
    with TickerProviderStateMixin {
  late TabController _moduleTabController;

  @override
  void initState() {
    super.initState();
    _moduleTabController = TabController(
      length: widget.modules.length,
      vsync: this,
    );
    _moduleTabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _moduleTabController.removeListener(_handleTabSelection);
    _moduleTabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_moduleTabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var module = widget.modules[_moduleTabController.index];

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: SizedBox(
            height: Sizes.size32,
            child: TabBar(
              controller: _moduleTabController,
              isScrollable: true,
              physics: const NeverScrollableScrollPhysics(),
              indicator: BoxDecoration(
                border: Border.all(
                  color: Colors.yellow.shade800,
                  width: Sizes.size2,
                ),
              ),
              labelColor: Colors.yellow.shade800,
              dividerHeight: 0,
              tabAlignment: TabAlignment.center,
              labelPadding: EdgeInsets.zero,
              unselectedLabelColor: Colors.black,
              tabs: [
                for (int i = 0; i < widget.modules.length; i++)
                  SizedBox(
                    width: Sizes.size64,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: AppFont(
                          '${widget.modules[i].typeIcon!.split('-').last.toUpperCase()}타입',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Gaps.v5,
        OperatorModuleInfoWidget(module: module),
      ],
    );
  }
}
