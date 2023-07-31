import 'package:arkhive/models/base/setting_model.dart';
import 'package:arkhive/models/common_models.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingCubit extends HydratedCubit<SettingState> {
  SettingCubit() : super(const SettingState.init());

  // TODO : update settings

  @override
  SettingState? fromJson(Map<String, dynamic> json) => SettingState(
        settings: json['setting'] as SettingModel,
        status: CommonLoadState.loaded,
      );

  @override
  Map<String, dynamic>? toJson(SettingState state) =>
      {'setting': state.settings};
}

class SettingState extends Equatable {
  final SettingModel settings;
  final CommonLoadState? status;

  const SettingState({
    required this.settings,
    this.status,
  });

  SettingState copyWith({
    SettingModel? settings,
    CommonLoadState? status,
  }) =>
      SettingState(
        settings: settings ?? this.settings,
        status: status ?? this.status,
      );

  const SettingState.init()
      : settings = const SettingModel(),
        status = CommonLoadState.init;

  @override
  List<Object?> get props => [
        settings,
        status,
      ];
}
