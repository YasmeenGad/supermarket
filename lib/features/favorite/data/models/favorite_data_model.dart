import 'package:supermarket/features/favorite/data/models/favorite_model.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';

class AddFavoriteModel {
  final bool status;
  final String message;
  final AddFavoriteDataModel favorites;

  const AddFavoriteModel({
    required this.status,
    required this.message,
    required this.favorites,
  });

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) {
    return AddFavoriteModel(
      status: json['status'] ?? false,
      message: json['message'] ?? 'No message provided',
      favorites: json['favorites'] != null
          ? AddFavoriteDataModel.fromJson(json['favorites'])
          : AddFavoriteDataModel(
              products: [],
              id: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'favorites': favorites.toJson(),
    };
  }

  AddFavorite toEntity() {
    return AddFavorite(
      products: favorites.products,
      id: favorites.id,
      createdAt: favorites.createdAt,
      updatedAt: favorites.updatedAt,
    );
  }
}
