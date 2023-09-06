import 'package:arkhive/models/item/item_model.dart';
import 'package:equatable/equatable.dart';

abstract class ItemDataState extends Equatable {
  const ItemDataState();

  @override
  List<Object?> get props => [];
}

class ItemDataInitState extends ItemDataState {
  const ItemDataInitState();

  @override
  List<Object?> get props => [];
}

class ItemDataLoadingState extends ItemDataState {
  const ItemDataLoadingState();

  @override
  List<Object?> get props => [];
}

class ItemDataLoadedState extends ItemDataState {
  final ItemModel item;

  const ItemDataLoadedState({
    required this.item,
  });

  @override
  List<Object?> get props => [item];
}

class ItemDataErrorState extends ItemDataState {
  final String message;

  const ItemDataErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
