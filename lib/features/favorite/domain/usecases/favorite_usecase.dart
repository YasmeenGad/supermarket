import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/entities/get_favorite.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorite_repo.dart';

typedef AddFavoriteResult = Either<String, AddFavorite>;
typedef GetFavoriteResult = Either<String, GetFavorite>;

class AddFavoriteProductsUseCase {
  final FavoriteRepository repository;

  AddFavoriteProductsUseCase(this.repository);

  Future<AddFavoriteResult> addFavoriteProducts(List<String> productIds) async {
    return repository.addFavoriteProducts(productIds);
  }

  Future<GetFavoriteResult> getFavoriteProducts(String id) async {
    return await repository.getFavoriteProducts(id);
  }
}
