import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';

class AddFavoriteModel extends AddFavorite {
  AddFavoriteModel({
    required String id,
    required List<String> products,
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

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) {
    return AddFavoriteModel(
      id: json['_id'],
      products: List<String>.from(json['products']),
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'products': products,
      'user': user,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
