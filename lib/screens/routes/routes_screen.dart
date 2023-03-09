import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/screens/enemy/enemy_screen.dart';
import 'package:arkhive/screens/gimmick/gimmick_screen.dart';
import 'package:arkhive/screens/home/home_screen.dart';
import 'package:arkhive/screens/item/item_screen.dart';
import 'package:arkhive/screens/operator/operator_screen.dart';
import 'package:arkhive/screens/stage/stage_screen.dart';
import 'package:arkhive/widgets/nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  Widget _screenSelector(Screens screen) {
    switch (screen) {
      case Screens.home:
        return const HomeScreen();
      case Screens.items:
        return const ItemScreen();
      case Screens.stages:
        return const StageScreen();
      case Screens.gimmick:
        return const GimmickScreen();
      case Screens.operators:
        return const OperatorScreen();
      case Screens.enemies:
        return const EnemyScreen();
      default:
        return const Center(
          child: Text('Page not found: 404'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Arkhive',
          style: TextStyle(
            fontFamily: FontFamily.nanumGothic,
            fontWeight: FontWeight.w700,
          ),
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
      body: BlocBuilder<ScreenBloc, ScreenState>(
        builder: (context, state) => _screenSelector(state.currScreen),
      ),
      drawer: const NavDrawer(),
    );
  }
}
