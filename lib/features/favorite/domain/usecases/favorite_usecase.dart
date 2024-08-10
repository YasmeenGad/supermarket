import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/add_favorite.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorite_repo.dart';

typedef AddFavoriteResult = Either<String, AddFavorite>;

class AddFavoriteProductsUseCase {
  final FavoriteRepository repository;

  AddFavoriteProductsUseCase(this.repository);

  Future<AddFavoriteResult> call(List<String> productIds) async {
    return repository.addFavoriteProducts(productIds);
  }
}
