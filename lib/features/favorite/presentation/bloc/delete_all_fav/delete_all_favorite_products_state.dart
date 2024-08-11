part of 'delete_all_favorite_products_bloc.dart';

@immutable
sealed class DeleteAllFavoriteProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DeleteAllFavoriteProductsInitial
    extends DeleteAllFavoriteProductsState {}

final class DeleteAllFavoriteProductsLoading
    extends DeleteAllFavoriteProductsState {}

final class DeleteAllFavoriteProductsSuccess
    extends DeleteAllFavoriteProductsState {
  final DeleteAllFavoritesProducts deleteAllFavoritesProducts;

  DeleteAllFavoriteProductsSuccess(this.deleteAllFavoritesProducts);

  @override
  List<Object?> get props => [deleteAllFavoritesProducts];
}

final class DeleteAllFavoriteProductsError
    extends DeleteAllFavoriteProductsState {
  final String message;

  DeleteAllFavoriteProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
