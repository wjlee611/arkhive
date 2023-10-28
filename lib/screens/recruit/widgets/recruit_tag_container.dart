import 'package:arkhive/bloc/recruit/engine/recruit_engine_bloc.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_event.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/recruit/widgets/recruit_tag_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruitTagContainer extends StatelessWidget {
  const RecruitTagContainer({super.key});

  Widget _seperator(BuildContext context) {
    return Column(
      children: [
        Gaps.v5,
        Container(
          width: double.infinity,
          height: Sizes.size2,
          color: Theme.of(context).shadowColor,
        ),
        Gaps.v5,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecruitEngineBloc, RecruitEngineState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(Sizes.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: Sizes.size5,
              runSpacing: Sizes.size5,
              children: [
                for (var item in state.star!.entries)
                  RecruitTagButton(
                    title: item.key.title,
                    onSelected: item.value,
                    onTap: () {
                      context
                          .read<RecruitEngineBloc>()
                          .add(RecruitEngineChangeStar(item.key));
                    },
                  ),
              ],
            ),
            _seperator(context),
            Wrap(
              spacing: Sizes.size5,
              runSpacing: Sizes.size5,
              children: [
                for (var item in state.range!.entries)
                  RecruitTagButton(
                    title: item.key.title,
                    onSelected: item.value,
                    onTap: () {
                      context
                          .read<RecruitEngineBloc>()
                          .add(RecruitEngineChangeRange(item.key));
                    },
                  ),
              ],
            ),
            _seperator(context),
            Wrap(
              spacing: Sizes.size5,
              runSpacing: Sizes.size5,
              children: [
                for (var item in state.profession!.entries)
                  RecruitTagButton(
                    title: item.key.ko,
                    onSelected: item.value,
                    onTap: () {
                      context
                          .read<RecruitEngineBloc>()
                          .add(RecruitEngineChangeProfession(item.key));
                    },
                  ),
              ],
            ),
            _seperator(context),
            Wrap(
              spacing: Sizes.size5,
              runSpacing: Sizes.size5,
              children: [
                for (var item in state.tags!.entries)
                  RecruitTagButton(
                    title: item.key,
                    onSelected: item.value,
                    onTap: () {
                      context
                          .read<RecruitEngineBloc>()
                          .add(RecruitEngineChangeTag(item.key));
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
