import 'package:arkhive/cubit/favorite_cubit.dart';
import 'package:arkhive/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonFavoriteWidget extends StatelessWidget {
  final String keyId;
  final String? iconId;
  final String? name;
  final String? diffGroup, difficulty; // only stage
  final FavorCategory category;

  const CommonFavoriteWidget({
    super.key,
    required this.keyId,
    this.iconId,
    this.name,
    this.diffGroup,
    this.difficulty,
    required this.category,
  });

  bool _isContain(FavoriteState state) {
    if (state.favs.contains(
      FavoriteModel(
        key: keyId,
        category: category,
      ),
    )) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            if (_isContain(state)) {
              context.read<FavoriteCubit>().popFavorite(
                    key: keyId,
                    category: category,
                  );
            } else {
              context.read<FavoriteCubit>().addFavoite(
                    key: keyId,
                    iconId: iconId,
                    name: name,
                    diffGroup: diffGroup,
                    difficulty: difficulty,
                    category: category,
                  );
            }
          },
          icon: Icon(
            _isContain(state) ? Icons.star : Icons.star_border_outlined,
            color: Colors.yellow.shade700,
          ),
        );
      },
    );
  }
}
