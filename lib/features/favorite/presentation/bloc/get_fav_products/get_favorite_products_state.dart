part of 'get_favorite_products_bloc.dart';

@immutable
sealed class GetFavoriteProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetFavoriteProductsInitial extends GetFavoriteProductsState {}

final class GetFavoriteProductsLoading extends GetFavoriteProductsState {}

final class GetFavoriteProductsSuccess extends GetFavoriteProductsState {
  final GetFavorite favorites;

  GetFavoriteProductsSuccess(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class GetFavoriteProductsError extends GetFavoriteProductsState {
  final String message;

  GetFavoriteProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
