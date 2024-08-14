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
      orderId: json['orderId'] as String? ?? '',  
      userId: json['userId'] as String? ?? '',    
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,  
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0, 
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(), 
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(), 
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
