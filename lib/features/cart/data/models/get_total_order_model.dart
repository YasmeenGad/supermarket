import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';

class GetTotalOrderModel extends GetTotalOrder {
  const GetTotalOrderModel({
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

  factory GetTotalOrderModel.fromJson(Map<String, dynamic> json) {
    return GetTotalOrderModel(
      orderId: json['orderId'],
      userId: json['userId'],
      totalAmount: json['totalAmount'],
      totalPrice: json['totalPrice'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
