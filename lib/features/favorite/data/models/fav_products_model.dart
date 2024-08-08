import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';

class FavProductsModel {
  final String id;
  final String productName;
  final double price;
  final int stock;
  final int quantity;
  final String productDetail;
  final int rate;
  final String slug;
  final String photo;
  final String categoryName;
  final bool bestSelling;
  final DateTime createdAt;
  final DateTime updatedAt;

  FavProductsModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.slug,
    required this.photo,
    required this.categoryName,
    required this.bestSelling,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavProductsModel.fromJson(Map<String, dynamic> json) {
    return FavProductsModel(
      id: json['_id'],
      productName: json['productName'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      quantity: json['quantity'],
      productDetail: json['productDetail'],
      rate: json['rate'],
      slug: json['slug'],
      photo: json['photo'],
      categoryName: json['categoryName'],
      bestSelling: json['bestSelling'].toLowerCase() == 'true',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'price': price,
      'stock': stock,
      'quantity': quantity,
      'productDetail': productDetail,
      'rate': rate,
      'slug': slug,
      'photo': photo,
      'categoryName': categoryName,
      'bestSelling': bestSelling.toString(), // Convert bool to String
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  FavProduct toEntity() {
    return FavProduct(
      id: id,
      productName: productName,
      price: price,
      stock: stock,
      quantity: quantity,
      productDetail: productDetail,
      rate: rate,
      slug: slug,
      photo: photo,
      categoryName: categoryName,
      bestSelling: bestSelling,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
