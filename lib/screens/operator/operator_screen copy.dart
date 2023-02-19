import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/operator/widgets/operator_class_listview_widget.dart';
import 'package:arkhive/screens/operator/widgets/operator_class_sticky_header_widget.dart';
import 'package:arkhive/tools/willpop_function.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import '../../global_data.dart';

class OperatorScreenOLD extends StatefulWidget {
  const OperatorScreenOLD({super.key});

  @override
  State<OperatorScreenOLD> createState() => _OperatorScreenOLDState();
}

class _OperatorScreenOLDState extends State<OperatorScreenOLD> {
  GlobalData globalData = GlobalData();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _controller = ScrollController();

  final List<bool> _isOpen = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  void _controllHeaderOpen({
    required int index,
    required SliverStickyHeaderState state,
  }) {
    setState(() {
      _isOpen[index] = !_isOpen[index];

      double offset = 0;
      const height = Sizes.size52;

      for (int i = 0; i < globalData.classedOperators.length; i++) {
        if (_isOpen[i]) {
          offset = offset + globalData.classedOperators[i].length * height;
        }
        offset = offset + height;
        if (i == index) {
          break;
        }
      }

      if (!_isOpen[index] && state.isPinned) {
        _controller.jumpTo(offset - Sizes.size52);
      }
    });
  }

  int _totalOperators() {
    int sum = 0;
    for (int i = 0; i < globalData.classedOperators.length; i++) {
      sum += globalData.classedOperators[i].length;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '오퍼레이터',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blueGrey.shade700,
        leading: IconButton(
          icon: const Icon(Icons.sort),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => WillPopFunction.onWillPop(context: context),
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            for (int index = 0;
                index < globalData.classedOperators.length;
                index++)
              SliverStickyHeader.builder(
                builder: (context, state) {
                  return OperatorClassStickyHeader(
                    controller: _controller,
                    controllHeaderOpen: _controllHeaderOpen,
                    state: state,
                    index: index,
                    numOperators: globalData.classedOperators[index].length,
                  );
                },
                sliver: OperatorClassListView(
                  classIdx: index,
                  isOpen: _isOpen[index],
                ),
              ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade700,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: Sizes.size2,
                      spreadRadius: Sizes.size2,
                    ),
                  ],
                ),
                height: Sizes.size48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '///    ${_totalOperators()} results    ///',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size12,
                        fontFamily: FontFamily.nanumGothic,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const NavDrawer(),
    );
  }
}
