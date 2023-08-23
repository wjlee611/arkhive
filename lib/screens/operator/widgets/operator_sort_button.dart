import 'package:arkhive/bloc/operator/operator_list/operator_list_bloc.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_event.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  void _onSelected(BuildContext context, SortOptions option) {
    context
        .read<OperatorListBloc>()
        .add(OperatorListSortEvent(sortOption: option));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperatorListBloc, OperatorListState>(
      builder: (context, state) => PopupMenuButton(
        initialValue: state.selectedSortOption,
        onSelected: (option) => _onSelected(context, option),
        offset: const Offset(0, 0),
        icon: Icon(
          Icons.filter_alt_rounded,
          color: Colors.yellow.shade800,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: Sizes.size5,
            color: Colors.blueGrey.shade700,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.size10)),
        ),
        elevation: 0,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: SortOptions.starUp,
            child: AppFont(
              '레어도 오름차순',
              fontSize: Sizes.size14,
            ),
          ),
          const PopupMenuItem(
            value: SortOptions.starDown,
            child: AppFont(
              '레어도 내림차순',
              fontSize: Sizes.size14,
            ),
          ),
          const PopupMenuItem(
            value: SortOptions.nameUp,
            child: AppFont(
              '이름 오름차순',
              fontSize: Sizes.size14,
            ),
          ),
          const PopupMenuItem(
            value: SortOptions.nameDown,
            child: AppFont(
              '이름 내림차순',
              fontSize: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
