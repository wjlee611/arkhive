import 'package:arkhive/models/base/setting_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SettingCubit extends HydratedCubit<SettingState> {
  SettingCubit() : super(const SettingState.init());

  @override
  SettingState? fromJson(Map<String, dynamic> json) => SettingState(
        settings: SettingModel.fromJson(json['setting']),
      );

  @override
  Map<String, dynamic>? toJson(SettingState state) => {
        'setting': state.settings.toJson(),
      };

  void toggleTheme() {
    emit(
      state.copyWith(
        settings: state.settings.copyWith(
          isDarkTheme: !(state.settings.isDarkTheme ?? false),
        ),
      ),
    );
  }
}

class SettingState extends Equatable {
  final SettingModel settings;

  const SettingState({
    required this.settings,
  });

  SettingState copyWith({
    SettingModel? settings,
  }) =>
      SettingState(
        settings: settings ?? this.settings,
      );

  const SettingState.init() : settings = const SettingModel(isDarkTheme: false);

  @override
  List<Object?> get props => [settings];
}
