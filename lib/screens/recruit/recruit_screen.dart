import 'package:arkhive/bloc/operator/operator_list/operator_list_bloc.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_event.dart';
import 'package:arkhive/bloc/operator/operator_list/operator_list_state.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_bloc.dart';
import 'package:arkhive/bloc/recruit/engine/recruit_engine_state.dart';
import 'package:arkhive/bloc/recruit/list/recruit_list_bloc.dart';
import 'package:arkhive/bloc/recruit/list/recruit_list_state.dart';
import 'package:arkhive/bloc/recruit/list/recurit_list_event.dart';
import 'package:arkhive/enums/common_load_state.dart';
import 'package:arkhive/models/recruit/recruit_model.dart';
import 'package:arkhive/screens/recruit/widgets/recruit_tag_container.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:arkhive/widgets/app_font.dart';
import 'package:arkhive/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const RecruitTagContainer(),
                        BlocBuilder<RecruitEngineBloc, RecruitEngineState>(
                          buildWhen: (previous, current) =>
                              previous.recruitList != current.recruitList,
                          builder: (context, state) => Column(
                            children: [
                              for (RecruitModel opList
                                  in state.recruitList ?? [])
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        for (var tag in opList.tags)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: AppFont(tag),
                                          ),
                                      ],
                                    ),
                                    for (var op in opList.operators)
                                      AppFont(op.name),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const CommonLoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
