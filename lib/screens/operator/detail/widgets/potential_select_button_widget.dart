import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';

class PotentialSelectButton extends StatefulWidget {
  const PotentialSelectButton({
    super.key,
    required this.onSelected,
    required this.length,
  });

  final Function(int) onSelected;
  final int length;

  @override
  State<PotentialSelectButton> createState() => _PotentialSelectButtonState();
}

class _PotentialSelectButtonState extends State<PotentialSelectButton> {
  int _potential = 0;

  void _onSelected(int pot) {
    widget.onSelected(pot);
    setState(() {
      _potential = pot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: _potential,
      onSelected: _onSelected,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: Sizes.size5,
          color: Colors.blueGrey.shade700,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 0,
      itemBuilder: (context) => [
        for (int i = 0; i < widget.length + 1; i++)
          PopupMenuItem(
            value: i,
            child: AppFont('잠재능력 ${i + 1}'),
          ),
      ],
      child: SizedBox(
        width: Sizes.size60,
        height: Sizes.size60,
        child: Center(
          child: Image.asset('assets/images/p${_potential + 1}.png'),
        ),
      ),
    );
  }
}
