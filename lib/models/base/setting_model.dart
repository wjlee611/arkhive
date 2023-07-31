import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class SettingModel extends Equatable {
  final bool? isLightTheme;

  const SettingModel({
    this.isLightTheme,
  });

  SettingModel copyWith({
    bool? isLightTheme,
  }) =>
      SettingModel(
        isLightTheme: isLightTheme ?? this.isLightTheme,
      );

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);

  @override
  List<Object?> get props => [isLightTheme];
}
