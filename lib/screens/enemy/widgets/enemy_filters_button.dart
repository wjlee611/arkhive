import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_bloc.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_event.dart';
import 'package:arkhive/bloc/enemy/enemy_list/enemy_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
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
    if (query?.isNotEmpty == true) return Colors.grey;

    return Colors.yellow.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnemyListBloc, EnemyListState>(
      buildWhen: (previous, current) {
        if (previous.selectedFilterOption != current.selectedFilterOption ||
            previous.searchQuery != current.searchQuery) {
          return true;
        }
        return false;
      },
      builder: (context_, state) => PopupMenuButton(
        enabled:
            context_.read<EnemyListBloc>().state.searchQuery?.isNotEmpty == true
                ? false
                : true,
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
        color: Theme.of(context).primaryColor,
        elevation: 0,
        itemBuilder: (context) => [
          for (int i = 0; i < 3; i++)
            PopupMenuItem(
              child: BlocBuilder<EnemyListBloc, EnemyListState>(
                buildWhen: (previous, current) =>
                    previous.selectedFilterOption !=
                    current.selectedFilterOption,
                bloc: context.read<EnemyListBloc>(),
                builder: (context, state) => CheckboxListTile(
                  value: state.selectedFilterOption?[i],
                  title: AppFont(
                    i == 0
                        ? '일반'
                        : i == 1
                            ? '정예'
                            : '보스',
                    color: i == 0
                        ? Theme.of(context).textTheme.bodyMedium!.color
                        : i == 1
                            ? Colors.deepOrange
                            : Colors.purple,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w700,
                  ),
                  onChanged: (value) => _onFilterChange(
                    context_,
                    index: i,
                    value: value,
                  ),
                  activeColor: Colors.yellow.shade800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
