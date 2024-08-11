import 'package:supermarket/features/favorite/domain/entities/delete_all_favorite_products.dart';

class DeleteAllFavoriteProductsModel extends DeleteAllFavoritesProducts{

  DeleteAllFavoriteProductsModel({
    required bool status,
    required String message,
  }):super(status: status, message: message);

  factory DeleteAllFavoriteProductsModel.fromJson(Map<String, dynamic> json) {
    return DeleteAllFavoriteProductsModel(
      status: json['status'] as bool,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() { 
    return {
      'status': status,
      'message': message,
    };
  }
}