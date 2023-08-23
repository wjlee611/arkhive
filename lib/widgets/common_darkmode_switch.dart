import 'package:arkhive/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonDarkmodeSwitch extends StatelessWidget {
  const CommonDarkmodeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      buildWhen: (previous, current) =>
          previous.settings.isDarkTheme != current.settings.isDarkTheme,
      builder: (context, state) => Switch(
        value: state.settings.isDarkTheme ?? false,
        activeColor: Colors.yellow.shade700,
        onChanged: (value) {
          context.read<SettingCubit>().toggleTheme();
        },
      ),
    );
  }
}
