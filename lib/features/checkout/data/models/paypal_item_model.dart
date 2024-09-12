import 'package:supermarket/features/checkout/domain/entities/paypal_item.dart';

class ItemModel extends Item {
  ItemModel({
    required String name,
    required int quantity,
    required String price,
    required String currency,
  }) : super(
          name: name,
          quantity: quantity,
          price: price,
          currency: currency,
        );

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price.toString(),
      'currency': currency,
    };
  }
}

class ItemsListModel extends ItemsList {
  ItemsListModel({
    required List<ItemModel> items,
  }) : super(
          items: items,
        );

  factory ItemsListModel.fromJson(Map<String, dynamic> json) {
    return ItemsListModel(
      items: (json['items'] as List)
          .map((item) => ItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => (item as ItemModel).toJson()).toList(),
    };
  }
}
