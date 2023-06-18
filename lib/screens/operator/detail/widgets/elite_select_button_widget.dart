import 'package:arkhive/constants/sizes.dart';
import 'package:flutter/material.dart';

class EliteSelectButton extends StatefulWidget {
  const EliteSelectButton({
    super.key,
    required this.onSelected,
    required this.length,
  });

  final Function(int) onSelected;
  final int length;

  @override
  State<EliteSelectButton> createState() => _EliteSelectButtonState();
}

class _EliteSelectButtonState extends State<EliteSelectButton> {
  int _elite = 0;

  void _onSelected(int elite) {
    widget.onSelected(elite);
    setState(() {
      _elite = elite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: _elite,
      onSelected: _onSelected,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: Sizes.size5,
          color: Colors.blueGrey.shade700,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
      ),
      elevation: 0,
      itemBuilder: (context) => [
        for (int i = 0; i < widget.length; i++)
          PopupMenuItem(
            value: i,
            child: Text(
              '정예화 단계 $i',
              style: const TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
      child: Transform.translate(
        offset: Offset(0, _elite == 2 ? -Sizes.size4 : -Sizes.size9),
        child: SizedBox(
          width: Sizes.size60,
          height: Sizes.size60,
          child: Center(
            child: Image.asset('assets/images/e$_elite.png'),
          ),
        ),
      ),
    );
  }
}
