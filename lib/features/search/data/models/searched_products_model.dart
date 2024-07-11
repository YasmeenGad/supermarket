// models/product_model.dart

import 'package:supermarket/features/search/domain/entities/searched_products.dart';

class SearchedProductsModel extends SearchedProducts {
  SearchedProductsModel({
    required String id,
    required String productName,
    required bool bestSelling,
    required double price,
    required int stock,
    required int quantity,
    required String productDetail,
    required double rate,
    required String categoryName,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String photo,
  }) : super(
          id: id,
          productName: productName,
          bestSelling: bestSelling,
          price: price,
          stock: stock,
          quantity: quantity,
          productDetail: productDetail,
          rate: rate,
          categoryName: categoryName,
          createdAt: createdAt,
          updatedAt: updatedAt,
          photo: photo,
        );

  factory SearchedProductsModel.fromJson(Map<String, dynamic> json) {
    return SearchedProductsModel(
      id: json['_id'],
      productName: json['productName'],
      bestSelling: json['bestSelling'] == 'true',
      price: json['price'].toDouble(),
      stock: json['stock'],
      quantity: json['quantity'],
      productDetail: json['productDetail'],
      rate: json['rate'].toDouble(),
      categoryName: json['categoryName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'bestSelling': bestSelling.toString(),
      'price': price,
      'stock': stock,
      'quantity': quantity,
      'productDetail': productDetail,
      'rate': rate,
      'categoryName': categoryName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'photo': photo,
    };
  }

  @override
  String toString() {
    return SearchedProductsModel(
            id: id,
            productName: productName,
            bestSelling: bestSelling,
            price: price,
            stock: stock,
            quantity: quantity,
            productDetail: productDetail,
            rate: rate,
            categoryName: categoryName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            photo: photo)
        .toString();
  }
}
