import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attribute_m_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AttributeMModel<T> extends Equatable {
  @JsonKey(name: 'm_defined')
  final bool mDefined;
  @JsonKey(name: 'm_value')
  final T? mValue;

  const AttributeMModel({
    required this.mDefined,
    this.mValue,
  });

  factory AttributeMModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeMModelFromJson(json, _fromJsonT<T>);

  Map<String, dynamic> toJson() => _$AttributeMModelToJson(this, _toJsonT<T>);

  static E _fromJsonT<E>(Object? data) {
    if (data == null) return Null as E;

    if (E == List<String>) {
      if (data is List<dynamic>) {
        return data.map((e) => e as String).toList() as E;
      }
    }
    if (E == String) {
      return data.toString() as E;
    }
    return data as E;
  }

  static Object? _toJsonT<E>(E value) {
    return value;
  }

  @override
  List<Object?> get props => [
        this.mDefined,
        this.mValue,
      ];
}
