import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_model.g.dart';

@JsonSerializable()
class SettingModel extends Equatable {
  final bool? isDarkTheme;
  final bool? isFirst;

  const SettingModel({
    this.isDarkTheme,
    this.isFirst,
  });

  SettingModel copyWith({
    bool? isDarkTheme,
    bool? isFirst,
  }) =>
      SettingModel(
        isDarkTheme: isDarkTheme ?? this.isDarkTheme,
        isFirst: isFirst ?? this.isFirst,
      );

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);

  @override
  List<Object?> get props => [
        isDarkTheme,
        isFirst,
      ];
}
