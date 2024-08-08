import 'package:supermarket/features/favorite/data/models/favorite_model.dart';
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
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      favorites: FavoriteData.fromJson(json['favorites'] ?? {}),
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
