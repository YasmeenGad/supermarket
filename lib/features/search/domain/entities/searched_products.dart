// entities/product_entity.dart

import 'package:equatable/equatable.dart';

class SearchedProducts extends Equatable {
  final String id;
  final String productName;
  final bool bestSelling;
  final double price;
  final int stock;
  final int quantity;
  final String productDetail;
  final double rate;
  final String categoryName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String photo;

  SearchedProducts({
    required this.id,
    required this.productName,
    required this.bestSelling,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        productName,
        bestSelling,
        price,
        stock,
        quantity,
        productDetail,
        rate,
        categoryName,
        createdAt,
        updatedAt,
        photo
      ];
}
