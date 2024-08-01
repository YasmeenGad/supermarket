import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';

class TotalOrderModel extends TotalOrder {
  const TotalOrderModel({
    required String orderId,
    required String userId,
    required int totalAmount,
    required double totalPrice,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: orderId,
          userId: userId,
          totalAmount: totalAmount,
          totalPrice: totalPrice,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TotalOrderModel.fromJson(Map<String, dynamic> json) {
    return TotalOrderModel(
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      totalAmount: (json['totalAmount'] as num).toInt(),  // Convert to double
      totalPrice: (json['totalPrice'] as num).toDouble(),    // Convert to double
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': id,
      'userId': userId,
      'totalAmount': totalAmount,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
