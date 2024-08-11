part of 'get_favorite_products_bloc.dart';

@immutable
sealed class GetFavoriteProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFavoriteProducts extends GetFavoriteProductsEvent {}
