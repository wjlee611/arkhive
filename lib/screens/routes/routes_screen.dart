import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/enemy/enemy_screen.dart';
import 'package:arkhive/screens/home/home_screen.dart';
import 'package:arkhive/screens/item/item_screen.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:arkhive/screens/routes/widgets/nav_widget.dart';
import 'package:arkhive/screens/stage/stage_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  DateTime? _currentBackPressTime;

  Widget _screenSelector(Screens screen) {
    switch (screen) {
      case Screens.home:
        return const HomeScreen();
      case Screens.items:
        return const ItemScreen();
      case Screens.stages:
        return const StageScreen();
      // case Screens.gimmick:
      //   return const GimmickScreen();
      case Screens.operators:
        return const OperatorScreen();
      case Screens.enemies:
        return const EnemyScreen();
      default:
        return const Center(
          child: AppFont('Page not found: 404'),
        );
    }
  }

  String _titleSelector(Screens screen) {
    switch (screen) {
      case Screens.home:
        return 'Arkhive';
      case Screens.items:
        return '창고 아이템';
      case Screens.stages:
        return '스테이지 정보';
      // case Screens.gimmick:
      //   return '스테이지 기믹';
      case Screens.operators:
        return '오퍼레이터';
      case Screens.enemies:
        return '적';
      default:
        return 'N/A';
    }
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          content: const AppFont(
            '종료할까요?',
            color: Colors.white,
            fontSize: Sizes.size14,
            fontWeight: FontWeight.w700,
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenBloc, ScreenState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: AppFont(
            _titleSelector(state.currScreen),
            color: Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Colors.blueGrey.shade700,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
        body: WillPopScope(
            onWillPop: _onWillPop, child: _screenSelector(state.currScreen)),
        drawer: const NavDrawer(),
      ),
    );
  }
}
