import 'package:supermarket/features/cart/domain/entities/order.dart';

class OrderModel extends MyOrder {
  OrderModel({
    required String userId,
    required List<String> products,
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          userId: userId,
          products: products,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'],
      products: List<String>.from(json['products']),
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
