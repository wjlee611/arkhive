import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/range_cubit.dart';
import 'package:arkhive/models/base/range_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class CommonRangeWidget extends StatelessWidget {
  final String? rangeId;

  const CommonRangeWidget({
    super.key,
    this.rangeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RangeCubit, RangeState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey.shade700,
            width: Sizes.size2,
          ),
          color: Colors.blueGrey.shade200,
        ),
        width: Sizes.size48,
        height: Sizes.size48,
        child: Transform.translate(
          offset: const Offset(-Sizes.size10, Sizes.size5),
          child: Transform.rotate(
            angle: -math.pi / 2,
            child: Stack(
              children: [
                for (RangeGridModel grid in (context
                        .read<RangeCubit>()
                        .state
                        .ranges?[rangeId]
                        ?.grids ??
                    []))
                  Transform.translate(
                    offset: Offset(
                      Sizes.size24 + (grid.row?.toDouble() ?? 0) * Sizes.size5,
                      Sizes.size24 + (grid.col?.toDouble() ?? 0) * Sizes.size5,
                    ),
                    child: Container(
                      width: Sizes.size4,
                      height: Sizes.size4,
                      color: Colors.white,
                    ),
                  ),
                Transform.translate(
                  offset: const Offset(Sizes.size24, Sizes.size24),
                  child: Container(
                    width: Sizes.size4,
                    height: Sizes.size4,
                    color: Colors.yellow.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
