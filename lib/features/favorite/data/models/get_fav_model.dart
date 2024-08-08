import 'package:supermarket/features/favorite/data/models/fav_products_model.dart';
import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';

class FavoriteProductsModel {
  final String id;
  final List<FavProductsModel> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  FavoriteProductsModel({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteProductsModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductsModel(
      id: json['_id'],
      products: List<FavProductsModel>.from(
        json['products'].map((x) => FavProductsModel.fromJson(x)),
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products.map((product) => product.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Favorite toEntity() {
    return Favorite(
      id: id,
      products: products.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
