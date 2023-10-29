import 'package:arkhive/bloc/operator/operator_list/operator_list_bloc.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_event.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_bloc.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/bloc/recruit/list/recruit_list_bloc.dart';
import 'package:arkhive/bloc/recruit/list/recruit_list_state.dart';
import 'package:arkhive/bloc/recruit/list/recurit_list_event.dart';
import 'package:arkhive/enums/common_load_state.dart';
import 'package:arkhive/screens/recruit/widgets/recruit_group_container.dart';
import 'package:arkhive/screens/recruit/widgets/recruit_tag_container.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class RecuritScreen extends StatelessWidget {
  const RecuritScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RecruitListBloc(),
        ),
        BlocProvider(
          create: (context) => OperatorListBloc(
            dbRegion: Region.kr,
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RecruitListBloc, RecruitListState>(
            listenWhen: (previous, current) =>
                !(current.operators?.isNotEmpty == true),
            listener: (context, state) {
              // Initialize Step 2
              if (state.operatorNames?.isNotEmpty == true) {
                context
                    .read<OperatorListBloc>()
                    .add(const OperatorListInitEvent());
              }
            },
          ),
          BlocListener<OperatorListBloc, OperatorListState>(
            listener: (context, state) {
              // Initialize Step 3
              if (state is OperatorListLoadedState) {
                context.read<RecruitListBloc>().add(RecruitListOpInitEvent(
                      state.operatorList ?? [],
                    ));
              }
            },
          ),
        ],
        child: Scaffold(
          body: BlocBuilder<RecruitListBloc, RecruitListState>(
            builder: (context, state) {
              // Initialize Step 1
              if (state.status == CommonLoadState.init) {
                context.read<RecruitListBloc>().add(RecruitListInitEvent());
              }
              if (state.status == CommonLoadState.error) {
                return const Center(
                  child: AppFont('데이터를 불러오는데 실패했습니다.'),
                );
              }
              if (state.status == CommonLoadState.loaded) {
                return BlocProvider(
                  create: (context) => RecruitEngineBloc(
                    operators: state.operators!,
                  ),
                  child: _buildBody(context: context),
                );
              }
              return const CommonLoadingWidget();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
  }) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: RecruitTagContainer(),
        ),
        BlocBuilder<RecruitEngineBloc, RecruitEngineState>(
          buildWhen: (previous, current) =>
              previous.recruitList != current.recruitList,
          builder: (context, state) => MultiSliver(
            children: [
              for (var item in state.recruitList ?? [])
                RecruitGroupContainer(group: item),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ),
      ],
    );
  }
}
