class Item {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });
}

class ItemsList {
  final List<Item> items;

  ItemsList({
    required this.items,
  });
}
