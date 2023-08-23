import 'package:flutter/material.dart';

class CommonDarkmodeSwitch extends StatelessWidget {
  const CommonDarkmodeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: false,
      activeColor: Colors.yellow.shade700,
      onChanged: (value) {
        // context.read<ItemPenguinBloc>().add(ItemPenguinToggleEvent(
        //       isIncludePerm: value,
        //     ));
      },
    );
  }
}
