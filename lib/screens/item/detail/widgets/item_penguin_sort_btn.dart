import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_event.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPenguinSortBtn extends StatelessWidget {
  final PenguinSortOption sortOption;

  const ItemPenguinSortBtn({
    super.key,
    required this.sortOption,
  });

  void _onTap(BuildContext context) {
    var bloc = context.read<ItemPenguinBloc>();
    if (bloc.state.sortOption == sortOption) return;
    if (bloc.state.status == CommonLoadState.loading) return;

    switch (sortOption) {
      case PenguinSortOption.sanity:
        {
          bloc.add(ItemPenguinSanitySortEvent());
          break;
        }
      case PenguinSortOption.rate:
        {
          bloc.add(ItemPenguinRateSortEvent());
          break;
        }
      case PenguinSortOption.times:
        {
          bloc.add(ItemPenguinTimesSortEvent());
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemPenguinBloc, ItemPenguinState>(
      builder: (context, state) => GestureDetector(
        onTap: () => _onTap(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size5,
            horizontal: Sizes.size10,
          ),
          decoration: BoxDecoration(
            color: state.sortOption == sortOption
                ? Colors.yellow.shade700
                : Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size40),
            border: Border.all(
              color: Colors.yellow.shade700,
              width: Sizes.size1,
            ),
          ),
          child: Text(
            sortOption.message,
            style: TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: state.sortOption == sortOption
                  ? FontWeight.w700
                  : FontWeight.w400,
              color:
                  state.sortOption == sortOption ? Colors.white : Colors.black,
              fontSize: Sizes.size12,
            ),
          ),
        ),
      ),
    );
  }
}
