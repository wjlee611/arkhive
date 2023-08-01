import 'package:arkhive/bloc/item/item_data/item_data_bloc.dart';
import 'package:arkhive/bloc/item/item_data/item_data_event.dart';
import 'package:arkhive/bloc/item/item_data/item_data_state.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/screens/item/detail/widgets/item_header_widget.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_header_widget.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({
    super.key,
    required this.itemKey,
    required this.iconId,
  });

  final String itemKey;
  final String iconId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDataBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "아이템 정보",
            style: TextStyle(
              fontFamily: FontFamily.nanumGothic,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.blueGrey.shade700,
          actions: [
            IconButton(
              onPressed: () {
                //TODO: 즐겨찾기 추가/삭제 알고리즘 추가
              },
              icon: Icon(
                Icons.star_border_outlined,
                color: Colors.yellow.shade700,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            BlocBuilder<ItemDataBloc, ItemDataState>(
              builder: (context, state) {
                if (state is ItemDataInitState) {
                  context
                      .read<ItemDataBloc>()
                      .add(ItemDataLoadEvent(itemKey: itemKey));
                }
                if (state is ItemDataLoadingState) {
                  return const CommonLoadingWidget();
                }
                if (state is ItemDataLoadedState) {
                  return _buildBody(
                    context: context,
                    item: state.item,
                  );
                }
                if (state is ItemDataErrorState) {
                  return Center(
                    child: Text('${state.message} 데이터를 불러오는데 실패했습니다.'),
                  );
                }
                return const CommonLoadingWidget();
              },
            ),
            ItemHeader(iconId: iconId),
          ],
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required ItemModel item,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Gaps.v130,
                CommonTitleWidget(
                  text: item.name,
                  color: Colors.yellow.shade800,
                ),
                Gaps.v5,
                FormattedTextWidget(text: item.description),
                if (item.obtainApproach != null)
                  Column(
                    children: [
                      Gaps.v32,
                      const CommonTitleWidget(
                        text: '획득 방법',
                      ),
                      Gaps.v5,
                      FormattedTextWidget(text: item.obtainApproach!),
                    ],
                  ),
              ],
            ),
          ),
          if (context.read<PenguinCubit>().state.items?.withId?[item.itemId] !=
              null)
            const ItemPenguinHeaderWidget(),
          if (context.read<PenguinCubit>().state.items?.withId?[item.itemId] !=
              null)
            BlocProvider(
              create: (context) => ItemPenguinBloc(context
                  .read<PenguinCubit>()
                  .state
                  .items!
                  .withId![item.itemId]!),
              child: const ItemPenguinWidget(),
            ),
          const SliverToBoxAdapter(
            child: Gaps.v130,
          ),
        ],
      ),
    );
  }
}
