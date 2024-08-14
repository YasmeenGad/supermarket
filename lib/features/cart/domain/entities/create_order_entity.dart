import 'package:equatable/equatable.dart';

class MyOrder extends Equatable {
  final bool status;
  final String userId;
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  MyOrder({
    required this.status,
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
