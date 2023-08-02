import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_event.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_state.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_item_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemPenguinWidget extends StatefulWidget {
  const ItemPenguinWidget({super.key});

  @override
  State<ItemPenguinWidget> createState() => _ItemPenguinWidgetState();
}

class _ItemPenguinWidgetState extends State<ItemPenguinWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemPenguinBloc, ItemPenguinState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == CommonLoadState.init) {
          context.read<ItemPenguinBloc>().add(ItemPenguinInitEvent());
        }
        if (state.status == CommonLoadState.error) {
          return const SliverToBoxAdapter(
            child: Text('데이터를 불러오는데 실패했습니다.'),
          );
        }
        if (state.filteredPenguin == null) {
          return const SliverToBoxAdapter(
            child: CommonLoadingWidget(),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ItemPenguinItemWidget(
                penguinData: state.filteredPenguin![index],
                idx: index,
              );
            },
            childCount: state.filteredPenguin?.length ?? 0,
          ),
        );
      },
    );
  }
}
