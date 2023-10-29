import 'package:arkhive/bloc/recruit/engine/recruit_engine_bloc.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_event.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/constants/sizes.dart';
import 'package:arkhive/screens/recruit/widgets/recruit_tag_button.dart';
import 'package:arkhive/widgets/app_font.dart';
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
            AppFont(
              '태그를 선택해주세요.',
              color: Theme.of(context).textTheme.labelSmall!.color,
              fontSize: Sizes.size12,
            ),
            Gaps.v5,
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
                for (var item in state.position!.entries)
                  RecruitTagButton(
                    title: item.key.value,
                    onSelected: item.value,
                    onTap: () {
                      context
                          .read<RecruitEngineBloc>()
                          .add(RecruitEngineChangePosition(item.key));
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
            _seperator(context),
            AppFont(
              '또는 태그를 직접 입력해주세요.',
              color: Theme.of(context).textTheme.labelSmall!.color,
              fontSize: Sizes.size12,
            ),
            Gaps.v5,
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Sizes.size2,
                    color: Colors.yellow.shade800,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.yellow.shade800,
                  ),
                ),
                hintText: '태그의 첫 글자를 적어주세요 (예: 근거리-근)',
                hintStyle: TextStyle(
                  color: Theme.of(context).textTheme.labelSmall!.color,
                ),
                border: InputBorder.none,
              ),
              cursorColor: Colors.yellow.shade800,
              autocorrect: false,
              enableSuggestions: false,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall!.color,
              ),
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
            ),
            Gaps.v10,
            AppFont(
              '*한국 서버 기준으로 계산됩니다.',
              color: Theme.of(context).textTheme.labelSmall!.color,
              fontSize: Sizes.size10,
            ),
            AppFont(
              '*자체 추전 알고리즘 기준으로 정렬됩니다.',
              color: Theme.of(context).textTheme.labelSmall!.color,
              fontSize: Sizes.size10,
            ),
            Gaps.v10,
            RecruitTagButton(
              title: '초기화',
              onSelected: false,
              isReset: true,
              onTap: () {
                context.read<RecruitEngineBloc>().add(RecruitEngineResetTag());
              },
            ),
          ],
        ),
      ),
    );
  }
}
