import 'package:arkhive/bloc/operator/operator_data/operator_data_bloc.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/constants/gaps.dart';
import 'package:arkhive/screens/operator/detail/operator_modules/widgets/operator_module_select_widget.dart';
import 'package:arkhive/widgets/common_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorModulesContainer extends StatelessWidget {
  const OperatorModulesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CommonTitleWidget(text: '모듈'),
        BlocBuilder<OperatorDataBloc, OperatorDataState>(
          builder: (context, state) {
            if (state is OperatorDataLoadedState) {
              return OperatorModuleSelectWidget(
                modules: state.modules,
              );
            }
            return Container();
          },
        ),
        Gaps.v32,
      ],
    );
  }
}
