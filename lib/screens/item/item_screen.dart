import 'package:arkhive/bloc/item/item_list/item_list_bloc.dart';
import 'package:arkhive/bloc/item/item_list/item_list_event.dart';
import 'package:arkhive/bloc/item/item_list/item_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/item/widgets/item_sliver_appbar_widget.dart';
import 'package:arkhive/tools/open_detail_screen.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/asset_image_widget.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:arkhive/widgets/common_no_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemListBloc(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const ItemSliverAppBar(),
            SliverFillRemaining(
              child: BlocBuilder<ItemListBloc, ItemListState>(
                builder: (context, state) {
                  if (state is ItemListInitState) {
                    context.read<ItemListBloc>().add(const ItemListInitEvent());
                  }
                  if (state is ItemListErrorState) {
                    return Center(
                      child: AppFont(
                        state.message,
                        fontSize: Sizes.size16,
                      ),
                    );
                  }
                  if (state is! ItemListLoadedState) {
                    return const CommonLoadingWidget();
                  }
                  if (state.filteredItemList.isEmpty) {
                    return const CommonNoResultWidget();
                  }
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size20,
                          horizontal: Sizes.size28,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: Sizes.size14,
                            crossAxisSpacing: Sizes.size14,
                            childAspectRatio: 1,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return GestureDetector(
                                onTap: () => OpenDetailScreen.onItemTab(
                                  itemKey: state.filteredItemList[index].itemId,
                                  iconId: state.filteredItemList[index].iconId,
                                  name: state.filteredItemList[index].name,
                                  context: context,
                                ),
                                child: Hero(
                                  tag: state.filteredItemList[index].iconId,
                                  child: AssetImageWidget(
                                    path:
                                        'assets/images/item/${state.filteredItemList[index].iconId}.png',
                                  ),
                                ),
                              );
                            },
                            childCount: state.filteredItemList.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
