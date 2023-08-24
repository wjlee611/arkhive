import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/constants/app_data.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewScreenListTile extends StatelessWidget {
  const NewScreenListTile({
    super.key,
    required this.id,
    required this.screen,
    required this.newScreen,
  });

  final String id;
  final Screens screen;
  final Widget newScreen;

  void _onTap({
    required BuildContext context,
    required bool isActive,
  }) {
    context.read<ScreenBloc>().add(ScreenChangeEvent(screen: screen));
    Scaffold.of(context).closeDrawer();
  }

  String _titleSelector(Screens screen) {
    switch (screen) {
      case Screens.home:
        return '메인 화면';
      case Screens.items:
        return '창고 아이템';
      case Screens.stages:
        return '스테이지 정보';
      case Screens.operators:
        return '오퍼레이터';
      case Screens.enemies:
        return '적';
      default:
        return AppData.nullStr;
    }
  }

  IconData _iconSelector(Screens screen) {
    switch (screen) {
      case Screens.home:
        return Icons.home_outlined;
      case Screens.items:
        return Icons.hive_outlined;
      case Screens.stages:
        return Icons.account_tree_outlined;
      case Screens.operators:
        return Icons.badge_outlined;
      case Screens.enemies:
        return Icons.whatshot_outlined;
      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenBloc, ScreenState>(
      builder: (context, state) => ListTile(
        leading: Icon(
          _iconSelector(screen),
          color: state.currScreen == screen
              ? Colors.yellow.shade700
              : Colors.white,
        ),
        title: AppFont(
          _titleSelector(screen),
          fontSize: Sizes.size14,
          color: state.currScreen == screen
              ? Colors.yellow.shade700
              : Colors.white,
          fontWeight:
              state.currScreen == screen ? FontWeight.w700 : FontWeight.w400,
        ),
        onTap: () => _onTap(
          context: context,
          isActive: state.currScreen != screen,
        ),
      ),
    );
  }
}
