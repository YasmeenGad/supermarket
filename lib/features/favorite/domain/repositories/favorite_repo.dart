import 'package:dartz/dartz.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_faorite_bloc/add_favorite_bloc.dart';

abstract class FavoriteRepository {
  Future<Either<String, AddFavorite>> addFavoriteProducts(List<String> productIds);
}