import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String userId;
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.userId,
    required this.products,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        userId,
        products,
        id,
        createdAt,
        updatedAt,
      ];
}
