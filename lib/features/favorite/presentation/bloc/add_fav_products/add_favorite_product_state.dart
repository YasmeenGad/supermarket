part of 'add_favorite_product_bloc.dart';

@immutable
sealed class AddFavoriteProductState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AddFavoriteProductInitial extends AddFavoriteProductState {}

final class AddFavoriteProductLoading extends AddFavoriteProductState {}

final class AddFavoriteProductSuccess extends AddFavoriteProductState {
  final AddFavorite addFavorite;
  AddFavoriteProductSuccess({required this.addFavorite});

  @override
  List<Object> get props => [addFavorite];
}

final class AddFavoriteProductFailure extends AddFavoriteProductState {
  final String message;
  AddFavoriteProductFailure({required this.message});

  @override
  List<Object> get props => [message];
}
