import 'package:arkhive/models/favorite_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_cubit.g.dart';

class FavoriteCubit extends HydratedCubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState.init());

  @override
  FavoriteState? fromJson(Map<String, dynamic> json) => FavoriteState(
        favs: FavoriteState.fromJson(json['favorite']).favs,
      );

  @override
  Map<String, dynamic>? toJson(FavoriteState state) => {
        'favorite': state.toJson(),
      };

  void addFavoite({
    required String key,
    String? iconId,
    String? name,
    String? diff,
    required FavorCategory category,
  }) {
    var list = state.favs.toList();
    list.add(FavoriteModel(
      key: key,
      iconId: iconId,
      name: name,
      diff: diff,
      category: category,
    ));

    emit(state.copyWith(
      favs: list.toSet().toList(),
    ));
  }

  void popFavorite({
    required String key,
    required FavorCategory category,
  }) {
    var list = state.favs.toList();
    list.remove(FavoriteModel(key: key, category: category));

    emit(state.copyWith(
      favs: list,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class FavoriteState extends Equatable {
  final List<FavoriteModel> favs;

  const FavoriteState({
    required this.favs,
  });

  const FavoriteState.init() : favs = const [];

  FavoriteState copyWith({
    List<FavoriteModel>? favs,
  }) =>
      FavoriteState(
        favs: favs ?? this.favs,
      );

  factory FavoriteState.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStateFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteStateToJson(this);

  @override
  List<Object?> get props => [favs];
}
