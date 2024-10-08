import 'package:supermarket/features/favorite/domain/entities/delete_one_favorite_product.dart';

class DeleteOneFavoriteProductModel extends DeleteOneFavoriteProduct {
  DeleteOneFavoriteProductModel({
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

  factory DeleteOneFavoriteProductModel.fromJson(Map<String, dynamic> json) {
  return DeleteOneFavoriteProductModel(
    id: json['_id'] ?? '',
    products: json['products'] != null ? List<String>.from(json['products']) : [],
    user: json['user'] ?? '',
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
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
