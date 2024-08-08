part of 'add_favorite_bloc.dart';

sealed class AddFavoriteState extends Equatable {
  const AddFavoriteState();
  
  @override
  List<Object> get props => [];
}

final class AddFavoriteInitial extends AddFavoriteState {}

class AddFavoriteLoading extends AddFavoriteState {}

class AddFavoriteSuccess extends AddFavoriteState {
  final Favorites favorites;

  const AddFavoriteSuccess(this.favorites);

  @override
  List<Object> get props => [favorites];
}

class AddFavoriteError extends AddFavoriteState {
  final String message;

  const AddFavoriteError(this.message);

  @override
  List<Object> get props => [message];
}

