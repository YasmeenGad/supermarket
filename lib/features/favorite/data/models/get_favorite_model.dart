import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';

class GetFavoriteProductModel extends GetFavoriteProduct {
  GetFavoriteProductModel({
    required String id,
    required String productName,
    required double price,
    required int quantity,
    required String productDetail,
    required String photo,
    required double rate,
  }) : super(
          rate: rate,
          id: id,
          productName: productName,
          price: price,
          quantity: quantity,
          productDetail: productDetail,
          photo: photo,
        );

  factory GetFavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return GetFavoriteProductModel(
      rate: json['rate'].toDouble(),
      id: json['_id'],
      productName: json['productName'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      productDetail: json['productDetail'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      '_id': id,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'productDetail': productDetail,
      'photo': photo,
    };
  }
}

class GetFavoriteModel extends GetFavorite {
  GetFavoriteModel({
    required String id,
    required List<GetFavoriteProductModel> products,
    required String user,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          products: products,
          user: user,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory GetFavoriteModel.fromJson(Map<String, dynamic> json) {
    return GetFavoriteModel(
      id: json['_id'],
      products: List<GetFavoriteProductModel>.from(
        json['products'].map(
            (productJson) => GetFavoriteProductModel.fromJson(productJson)),
      ),
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products.map((product) => (product as GetFavoriteProductModel).toJson()).toList(),  // Convert each product to JSON
      'user': user,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
