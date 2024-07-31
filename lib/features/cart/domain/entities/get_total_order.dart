import 'package:equatable/equatable.dart';

class GetTotalOrder extends Equatable {
  final String id;
  final String userId;
  final int totalAmount;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GetTotalOrder({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, totalAmount, totalPrice, createdAt, updatedAt];
}
