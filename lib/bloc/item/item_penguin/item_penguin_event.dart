import 'package:arkhive/models/base/penguin_model.dart';

abstract class ItemPenguinEvent {
  ItemPenguinEvent();
}

class ItemPenguinInitEvent extends ItemPenguinEvent {
  final List<PenguinModel> penguinSrc;

  ItemPenguinInitEvent({
    required this.penguinSrc,
  });
}

class ItemPenguinSanitySortEvent extends ItemPenguinEvent {
  ItemPenguinSanitySortEvent();
}

class ItemPenguinRateSortEvent extends ItemPenguinEvent {
  ItemPenguinRateSortEvent();
}

class ItemPenguinTimesSortEvent extends ItemPenguinEvent {
  ItemPenguinTimesSortEvent();
}

class ItemPenguinToggleEvent extends ItemPenguinEvent {
  final bool isIncludePerm;

  ItemPenguinToggleEvent({
    required this.isIncludePerm,
  });
}
