import 'package:equatable/equatable.dart';

class FavProduct extends Equatable {
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

  const FavProduct({
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

  // Add toJson method to the entity
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
      'bestSelling': bestSelling.toString(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, productName, price, stock, quantity, productDetail, rate, slug, photo, categoryName, bestSelling, createdAt, updatedAt];
}

class Favorite extends Equatable {
  final String id;
  final List<FavProduct> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Favorite({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, products, createdAt, updatedAt];
}
