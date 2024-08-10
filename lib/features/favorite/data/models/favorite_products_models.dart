import 'package:supermarket/features/favorite/domain/entities/favorite_entities.dart';

class FavProductsModel extends FavProduct {
  FavProductsModel({
    required String id,
    required String productName,
    required double price,
    required int stock,
    required int quantity,
    required String productDetail,
    required int rate,
    required String slug,
    required String photo,
    required String categoryName,
    required bool bestSelling,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
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

  factory FavProductsModel.fromJson(Map<String, dynamic> json) {
    return FavProductsModel(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      quantity: json['quantity'] ?? 0,
      productDetail: json['productDetail'] ?? '',
      rate: json['rate'] ?? 0,
      slug: json['slug'] ?? '',
      photo: json['photo'] ?? '',
      categoryName: json['categoryName'] ?? '',
      bestSelling: json['bestSelling'] == 'true' || json['bestSelling'] == true,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
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
      'bestSelling': bestSelling.toString(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class FavoriteModel extends Favorite {
  FavoriteModel({
    required String id,
    required List<FavProductsModel> products,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          products: products,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['_id'] ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((x) => FavProductsModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
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
}
