import 'package:equatable/equatable.dart';

class BestSellingProducts extends Equatable {
  final String id;
  final String productName;
  final double price;
  final int stock;
  final int quantity;
  final String productDetail;
  final double rate;
  final String createdAt;
  final String updatedAt;
  final String? photo;
  final String categoryName;
  final bool bestSelling;

  BestSellingProducts({
    required this.id,
    required this.productName,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.createdAt,
    required this.updatedAt,
    this.photo,
    required this.categoryName,
    required this.bestSelling,
  });
  
  @override
  List<Object?> get props => [
    id, 
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
    bestSelling
  ];
}
