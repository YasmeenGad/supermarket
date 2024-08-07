import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';

class FavoriteModel {
  final bool status;
  final String message;
  final FavoriteData favorites;

  const FavoriteModel({
    required this.status,
    required this.message,
    required this.favorites,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      status: json['status'],
      message: json['message'],
      favorites: FavoriteData.fromJson(json['favorites']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'favorites': favorites.toJson(),
    };
  }

  Favorites toEntity() {
    return Favorites(
      products: favorites.products,
      id: favorites.id,
      createdAt: favorites.createdAt,
      updatedAt: favorites.updatedAt,
    );
  }
}

class FavoriteData {
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FavoriteData({
    required this.products,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) {
    return FavoriteData(
      products: List<String>.from(json['products']),
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
