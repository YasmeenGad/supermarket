import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/domain/entities/fav_products.dart';
import 'package:supermarket/features/favorite/domain/entities/favorite_data.dart';
import 'package:supermarket/features/favorite/domain/repositories/favorites_repo.dart';

typedef FavoritesResult = Either<String, Favorites>;
typedef GetFavoriteResult= Either<String, Favorite>;

class FavoritesUsecase {
  final FavoritesRepository favoritesRepository;

  FavoritesUsecase(this.favoritesRepository);

  Future<FavoritesResult> addFavoriteProducts(List<String> productIds) async {
    return await favoritesRepository.addFavoriteProducts(productIds);
  }

  Future<GetFavoriteResult> getFavoriteProducts(String id) async {
    return await favoritesRepository.getFavoriteProducts(id);
  }
}
