import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String id;
  final String productName;
  final double price;
  final int stock;
  final int quantity;
  final String productDetail;
  final double rate;
  final String createdAt;
  final String updatedAt;
  final String photo;
  final String categoryName;
  final bool bestSelling;

  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.categoryName,
    required this.bestSelling,
  });
  
  @override

  List<Object?> get props => [
    productName,
    price,
    stock,
    quantity,
    productDetail,
    rate,
    createdAt,
    updatedAt,
    photo,
    categoryName,
    bestSelling,
  ];
}
