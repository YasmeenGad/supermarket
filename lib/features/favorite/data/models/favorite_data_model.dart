import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';

class FavoriteModel extends Favorites {
  FavoriteModel({
    required List<String> products,
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
            products: products,
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      products: List<String>.from(json['products'].map((x) => x)),
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
