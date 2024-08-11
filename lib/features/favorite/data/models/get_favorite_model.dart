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
          id: id,
          productName: productName,
          price: price,
          quantity: quantity,
          productDetail: productDetail,
          photo: photo,
          rate: rate,
        );

  factory GetFavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return GetFavoriteProductModel(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      productDetail: json['productDetail'] ?? '',
      photo: json['photo'] ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'productDetail': productDetail,
      'photo': photo,
      'rate': rate,
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
      id: json['_id'] ?? '',
      products: (json['products'] as List)
          .map((productJson) => GetFavoriteProductModel.fromJson(productJson as Map<String, dynamic>))
          .toList(),
      user: json['user'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products.map((product) => (product as GetFavoriteProductModel).toJson()).toList(),
      'user': user,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Add the copyWith method here
GetFavoriteModel copyWith({
  String? id,
  List<GetFavoriteProductModel>? products,
  String? user,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  List<GetFavoriteProductModel> convertedProducts = this.products.map((product) => GetFavoriteProductModel.fromJson((product as GetFavoriteProductModel).toJson())).toList();
  return GetFavoriteModel(
    id: id ?? this.id,
    products: products ?? convertedProducts,
    user: user ?? this.user,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
}

class FavoriteResponseModel extends FavoriteResponse {
  FavoriteResponseModel({
    required bool status,
    required String message,
    required List<GetFavoriteModel> fav,
  }) : super(
          status: status,
          message: message,
          fav: fav,
        );

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      fav: (json['fav'] as List)
          .map((favJson) => GetFavoriteModel.fromJson(favJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'fav': fav.map((favorite) => (favorite as GetFavoriteModel).toJson()).toList(),
    };
  }
}
