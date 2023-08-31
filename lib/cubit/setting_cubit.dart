import 'package:arkhive/models/base/setting_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
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

  // SettingModel.isDarkTheme
  void toggleTheme() {
    emit(
      state.copyWith(
        settings: state.settings.copyWith(
          isDarkTheme: !(state.settings.isDarkTheme ?? false),
        ),
      ),
    );
  }

  // SettingModel.isFirst
  void firstRun() {
    emit(
      state.copyWith(
        settings: state.settings.copyWith(
          isFirst: false,
        ),
      ),
    );
  }

  // SettingModel.dbRegion
  void changeRegion({required Region dbRegion}) {
    emit(
      state.copyWith(
        settings: state.settings.copyWith(
          dbRegion: dbRegion,
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

  const SettingState.init()
      : settings = const SettingModel(
          isDarkTheme: false,
          isFirst: true,
          dbRegion: Region.kr,
        );

  @override
  List<Object?> get props => [settings];
}
