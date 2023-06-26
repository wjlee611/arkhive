import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_event.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/models/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnemyFiltersButton extends StatelessWidget {
  const EnemyFiltersButton({super.key});

  void _onFilterChange(
    BuildContext context, {
    required int index,
    required bool? value,
  }) {
    var filters =
        context.read<EnemyListBloc>().state.selectedFilterOption?.toList();
    if (filters == null) return;

    filters[index] = value ?? false;
    context
        .read<EnemyListBloc>()
        .add(EnemyListSelectFiltersEvent(filters: filters));
  }

  Color _iconColorSelector(BuildContext context) {
    var filters = context.read<EnemyListBloc>().state.selectedFilterOption;
    if (filters == null) return Colors.white;
    if (!filters.any((element) => element)) return Colors.white;

    var query = context.read<EnemyListBloc>().state.searchQuery;
    if (query?.isNotEmpty == true) return Colors.white;

    return Colors.yellow.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyListBloc, EnemyListState>(
      buildWhen: (previous, current) =>
          previous.selectedFilterOption != current.selectedFilterOption,
      builder: (context_, state) => PopupMenuButton(
        offset: const Offset(0, 0),
        icon: Icon(
          Icons.filter_alt_rounded,
          color: _iconColorSelector(context),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: Sizes.size5,
            color: Colors.blueGrey.shade700,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: BlocBuilder<EnemyListBloc, EnemyListState>(
              buildWhen: (previous, current) =>
                  previous.selectedFilterOption != current.selectedFilterOption,
              bloc: context.read<EnemyListBloc>(),
              builder: (context, state) => Column(
                children: [
                  for (int i = 0; i < 3; i++)
                    CheckboxListTile(
                      value: state.selectedFilterOption?[i],
                      title: Text(
                        i == 0
                            ? '일반'
                            : i == 1
                                ? '정예'
                                : '보스',
                        style: const TextStyle(
                          fontFamily: FontFamily.nanumGothic,
                        ),
                      ),
                      onChanged: (value) => _onFilterChange(
                        context_,
                        index: i,
                        value: value,
                      ),
                      activeColor: Colors.yellow.shade800,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
