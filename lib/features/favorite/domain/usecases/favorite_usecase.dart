import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_one_favorite_product.dart';
import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorite_repo.dart';

typedef AddFavoriteResult = Either<String, AddFavorite>;
typedef GetFavoriteResult = Either<String, GetFavorite>;
typedef DeleteOneFavoriteProductResult
    = Either<String, DeleteOneFavoriteProduct>;

class AddFavoriteProductsUseCase {
  final FavoriteRepository repository;

  AddFavoriteProductsUseCase(this.repository);

  Future<AddFavoriteResult> addFavoriteProducts(List<String> productIds) async {
    return repository.addFavoriteProducts(productIds);
  }

  Future<GetFavoriteResult> getFavoriteProducts() async {
    return await repository.getFavoriteProducts();
  }

  Future<DeleteOneFavoriteProductResult> deleteOneFavoriteProduct(
      List<String> productId) async {
    return await repository.deleteOneFavoriteProduct(productId);
  }
}
