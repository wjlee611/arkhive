// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteState _$FavoriteStateFromJson(Map<String, dynamic> json) =>
    FavoriteState(
      favs: (json['favs'] as List<dynamic>)
          .map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteStateToJson(FavoriteState instance) =>
    <String, dynamic>{
      'favs': instance.favs.map((e) => e.toJson()).toList(),
    };
