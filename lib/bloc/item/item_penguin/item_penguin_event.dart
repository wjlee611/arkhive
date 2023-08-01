abstract class ItemPenguinEvent {
  ItemPenguinEvent();
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
