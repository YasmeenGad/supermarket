import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';

class OrderModel extends MyOrder {
  OrderModel({
    required bool status,
    required String userId,
    required List<String> products,
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          status: status,
          userId: userId,
          products: products,
          id: id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'] as bool? ?? false,
      userId: json['userId'] as String? ?? '', // Provide default value if null
      products: List<String>.from(json['products'] ?? []), // Handle null list
      id: json['_id'] as String? ?? '', // Provide default value if null
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(), // Handle null or invalid date
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(), // Handle null or invalid date
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'userId': userId,
      'products': products,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
