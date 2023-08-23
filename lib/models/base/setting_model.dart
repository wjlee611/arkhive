import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class SettingModel extends Equatable {
  final bool? isDarkTheme;

  const SettingModel({
    this.isDarkTheme,
  });

  SettingModel copyWith({
    bool? isDarkTheme,
  }) =>
      SettingModel(
        isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      );

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);

  @override
  List<Object?> get props => [isDarkTheme];
}
