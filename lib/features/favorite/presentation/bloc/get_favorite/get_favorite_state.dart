part of 'get_favorite_bloc.dart';

sealed class GetFavoriteState extends Equatable {
  const GetFavoriteState();

  @override
  List<Object> get props => [];
}

final class GetFavoriteInitial extends GetFavoriteState {}

class GetFavoriteLoading extends GetFavoriteState {}

class GetFavoriteSuccess extends GetFavoriteState {
  final Favorite favoriteProducts;
  const GetFavoriteSuccess(this.favoriteProducts);

  @override
  List<Object> get props => [favoriteProducts];
}

class GetFavoriteError extends GetFavoriteState {
  final String message;
  const GetFavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
