import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/screen.dart';
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

  Widget _screenSelector(EScreen screen) {
    switch (screen) {
      case EScreen.home:
        return const HomeScreen();
      case EScreen.items:
        return const ItemScreen();
      case EScreen.stages:
        return const StageScreen();
      case EScreen.operators:
        return const OperatorScreen();
      case EScreen.enemies:
        return const EnemyScreen();
      default:
        return const Center(
          child: AppFont('Page not found: 404'),
        );
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
            state.currScreen == EScreen.home ? 'Arkhive' : state.currScreen.ko,
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
