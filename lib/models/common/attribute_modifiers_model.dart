import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attribute_modifiers_model.g.dart';

@JsonSerializable()
class AttributeModifiersModel extends Equatable {
  @JsonKey(fromJson: _fromJsonToString)
  final String attributeType; // CN: int -> String
  final int formulaItem;
  final double value;
  final bool loadFromBlackboard;
  final bool fetchBaseValueFromSourceEntity;

  const AttributeModifiersModel({
    required this.attributeType,
    required this.formulaItem,
    required this.value,
    required this.loadFromBlackboard,
    required this.fetchBaseValueFromSourceEntity,
  });

  factory AttributeModifiersModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModifiersModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeModifiersModelToJson(this);

  static String _fromJsonToString(dynamic value) => value.toString();

  @override
  List<Object?> get props => [
        attributeType,
        formulaItem,
        value,
        loadFromBlackboard,
        fetchBaseValueFromSourceEntity,
      ];
}
