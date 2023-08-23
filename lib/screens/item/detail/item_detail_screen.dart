import 'package:arkhive/bloc/item/item_data/item_data_bloc.dart';
import 'package:arkhive/bloc/item/item_data/item_data_event.dart';
import 'package:arkhive/bloc/item/item_data/item_data_state.dart';
import 'package:arkhive/bloc/item/item_penguin/item_penguin_bloc.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/cubit/penguin_cubit.dart';
import 'package:arkhive/models/favorite_model.dart';
import 'package:arkhive/models/item_model.dart';
import 'package:arkhive/screens/item/detail/widgets/item_header_widget.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_header_widget.dart';
import 'package:arkhive/screens/item/detail/widgets/item_penguin_widget.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_favorite_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:arkhive/widgets/formatted_text_widget.dart';
import 'package:arkhive/widgets/penguin_server_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({
    super.key,
    required this.itemKey,
    required this.name,
    required this.iconId,
  });

  final String itemKey;
  final String name;
  final String iconId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDataBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const AppFont(
            "아이템 정보",
            color: Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Colors.blueGrey.shade700,
          actions: [
            const PenguinServerSelector(),
            CommonFavoriteWidget(
              keyId: itemKey,
              iconId: iconId,
              name: name,
              category: FavorCategory.item,
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
                    child: AppFont('${state.message} 데이터를 불러오는데 실패했습니다.'),
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
    return BlocProvider(
      create: (context) => ItemPenguinBloc(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
            if (context
                    .read<PenguinCubit>()
                    .state
                    .items
                    ?.withId?[item.itemId] !=
                null)
              const ItemPenguinHeaderWidget(),
            if (context
                    .read<PenguinCubit>()
                    .state
                    .items
                    ?.withId?[item.itemId] !=
                null)
              ItemPenguinWidget(
                itemId: item.itemId,
              ),
            const SliverToBoxAdapter(
              child: Gaps.v130,
            ),
          ],
        ),
      ),
    );
  }
}
