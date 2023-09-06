import 'package:arkhive/bloc/screen_bloc.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/enums/screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewScreenListTile extends StatelessWidget {
  const NewScreenListTile({
    super.key,
    required this.screen,
    required this.newScreen,
  });

  final EScreen screen;
  final Widget newScreen;

  void _onTap({
    required BuildContext context,
    required bool isActive,
  }) {
    context.read<ScreenBloc>().add(ScreenChangeEvent(screen: screen));
    Scaffold.of(context).closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenBloc, ScreenState>(
      builder: (context, state) => ListTile(
        leading: Icon(
          screen.icon,
          color: state.currScreen == screen
              ? Colors.yellow.shade700
              : Colors.white,
        ),
        title: AppFont(
          screen.ko,
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
