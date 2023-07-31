abstract class ItemDataEvent {
  const ItemDataEvent();
}

class ItemDataLoadEvent extends ItemDataEvent {
  final String itemKey;

  const ItemDataLoadEvent({
    required this.itemKey,
  });
}
