import 'package:arkhive/models/base/penguin_model.dart';
import 'package:flutter/material.dart';

class StagePenguinItemWidget extends StatelessWidget {
  final PenguinStageModel penguin;

  const StagePenguinItemWidget({
    super.key,
    required this.penguin,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        '[${penguin.isFirstDrop}] ${penguin.name ?? 'n/a'} - ${(penguin.sanityx1000 ?? 0) / 1000}');
  }
}
