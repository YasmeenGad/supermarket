import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';

class GetFavoriteProductModel extends GetFavoriteProduct {
  GetFavoriteProductModel({
    required String id,
    required String productName,
    required double price,
    required int quantity,
    required String productDetail,
    required String photo,
  }) : super(
          id: id,
          productName: productName,
          price: price,
          quantity: quantity,
          productDetail: productDetail,
          photo: photo,
        );

  factory GetFavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return GetFavoriteProductModel(
      id: json['_id'],
      productName: json['productName'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      productDetail: json['productDetail'],
      photo: json['photo'],
    );
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
        json['products'].map((productJson) => GetFavoriteProductModel.fromJson(productJson)),
      ),
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
