import 'dart:convert';

import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OperatorModuleContainer extends StatefulWidget {
  const OperatorModuleContainer({
    super.key,
    required this.operatorKey,
  });

  final String operatorKey;

  @override
  State<OperatorModuleContainer> createState() =>
      _OperatorModuleContainerState();
}

class _OperatorModuleContainerState extends State<OperatorModuleContainer>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  List<ModuleModel> modules = [];
  Map<String, ModuleDataModel> moduleDatas = {};
  late TabController _moduleTabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _loadModule();
  }

  void _loadModule() async {
    const storage = FlutterSecureStorage();
    String operatorName = widget.operatorKey.split('_').last;
    for (int i = 2; i < 4; i++) {
      try {
        // Module
        var moduleString =
            await storage.read(key: 'module/uniequip_00${i}_$operatorName');
        var moduleJson = await json.decode(moduleString!);
        modules.add(ModuleModel.fromJson(moduleJson));

        // Module data
        moduleString = await storage.read(
            key: 'module_data/uniequip_00${i}_$operatorName');
        moduleJson = await json.decode(moduleString!);
        moduleDatas['uniequip_00${i}_$operatorName'] =
            ModuleDataModel.fromJson(moduleJson);
      } catch (_) {}
    }
    modules.sort(
      (a, b) => a.typeIcon!.compareTo(b.typeIcon!),
    );

    _moduleTabController = TabController(length: modules.length, vsync: this);
    _moduleTabController.addListener(_handleModuleTabSelection);
    try {
      setState(() {
        _isLoading = false;
      });
    } catch (_) {}
  }

  void _handleModuleTabSelection() {
    if (_moduleTabController.indexIsChanging) {
      setState(() {
        _index = _moduleTabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? modules.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const CommonTitleWidget(text: '모듈'),
                  Gaps.v5,
                  Center(
                    child: Container(
                      height: Sizes.size24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(Sizes.size10),
                      ),
                      child: TabBar(
                        controller: _moduleTabController,
                        isScrollable: true,
                        physics: const NeverScrollableScrollPhysics(),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          color: Colors.yellow.shade800,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        splashBorderRadius: BorderRadius.circular(Sizes.size10),
                        tabs: [
                          for (int i = 0; i < modules.length; i++)
                            SizedBox(
                              width: Sizes.size40,
                              child: Tab(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: Sizes.size2),
                                  child: Text(
                                    '${modules[i].typeIcon!.split('-').last.toUpperCase()}타입',
                                    style: const TextStyle(
                                      fontFamily: FontFamily.nanumGothic,
                                      fontWeight: FontWeight.w700,
                                      fontSize: Sizes.size12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Gaps.v5,
                  OperatorModuleInfoWidget(
                    name: modules[_index].uniEquipName!,
                    type: modules[_index].typeIcon!,
                    module: moduleDatas[modules[_index].uniEquipId!]!,
                  ),
                ],
              )
            : Container()
        : Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade800,
            ),
          );
  }
}

class OperatorModuleInfoWidget extends StatefulWidget {
  const OperatorModuleInfoWidget({
    super.key,
    required this.name,
    required this.type,
    required this.module,
  });

  final String name, type;
  final ModuleDataModel module;

  @override
  State<OperatorModuleInfoWidget> createState() =>
      _OperatorModuleInfoWidgetState();
}

class _OperatorModuleInfoWidgetState extends State<OperatorModuleInfoWidget>
    with TickerProviderStateMixin {
  late TabController _stageTabController;

  @override
  void initState() {
    super.initState();
    _stageTabController =
        TabController(length: widget.module.phases.length, vsync: this);
    _stageTabController.addListener(_handleModuleTabSelection);
  }

  @override
  void didUpdateWidget(covariant OperatorModuleInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.module.phases.length != widget.module.phases.length) {
      _stageTabController.removeListener(_handleModuleTabSelection);
      _stageTabController.dispose();

      _stageTabController =
          TabController(length: widget.module.phases.length, vsync: this);
      _stageTabController.addListener(_handleModuleTabSelection);
    }
  }

  @override
  void dispose() {
    _stageTabController.dispose();
    super.dispose();
  }

  void _handleModuleTabSelection() {
    if (_stageTabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var module = widget.module.phases[_stageTabController.index];
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Center(
          child: Container(
            height: Sizes.size24,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Sizes.size10),
            ),
            child: TabBar(
              controller: _stageTabController,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.size10),
                color: Colors.yellow.shade800,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              splashBorderRadius: BorderRadius.circular(Sizes.size10),
              tabs: [
                for (int i = 0; i < widget.module.phases.length; i++)
                  SizedBox(
                    width: Sizes.size52,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Sizes.size2),
                        child: Text(
                          'Stage ${i + 1}',
                          style: const TextStyle(
                            fontFamily: FontFamily.nanumGothic,
                            fontWeight: FontWeight.w700,
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Gaps.v7,
        CommonSubTitleWidget(text: widget.name),
        Text(widget.type.toUpperCase()),
        Text(_stageTabController.index.toString()),
      ],
    );
  }
}
