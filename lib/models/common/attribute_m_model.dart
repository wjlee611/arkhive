import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attribute_m_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AttributeMModel<T> extends Equatable {
  @JsonKey(name: 'm_defined')
  final bool mDefined;
  @JsonKey(name: 'm_value')
  final T mValue;

  const AttributeMModel({
    required this.mDefined,
    required this.mValue,
  });

  factory AttributeMModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeMModelFromJson(json, _fromJsonT);

  Map<String, dynamic> toJson() => _$AttributeMModelToJson(this, _toJsonT);

  T _fromJsonT<T>(Object? data) {
    if (T == List<String>) {
      if (data is List<dynamic>) {
        return data.map((e) => e as String).toList() as T;
      }
    }
    return data as T;
    // if (T == String) {
    //   return data as T;
    // }
    // if (T == int) {
    //     return data as T;
    //   if (data is int) {
    //   }
    // }
    // if (T == double) {
    //     return data as T;
    //   if (data is double) {
    //   }
    // }
    // return -1 as T;
  }

  Object? _toJsonT<T>(T value) {
    return value;
  }

  @override
  List<Object?> get props => [
        this.mDefined,
        this.mValue,
      ];
}
