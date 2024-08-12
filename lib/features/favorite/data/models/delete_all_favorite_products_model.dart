import 'package:supermarket/features/favorite/domain/entities/delete_all_favorite_products.dart';

class DeleteAllFavoriteProductsModel extends DeleteAllFavoritesProducts {
  DeleteAllFavoriteProductsModel({
    required bool status,
    required String message,
  }) : super(status: status, message: message);

  factory DeleteAllFavoriteProductsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case where the json is null
      return DeleteAllFavoriteProductsModel(
        status: false, // Default to false if no status is provided
        message: 'No message', // Provide a default message
      );
    }

    return DeleteAllFavoriteProductsModel(
      status: json['status'] as bool? ?? false,
      message: json['message'] as String? ?? 'No message',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
