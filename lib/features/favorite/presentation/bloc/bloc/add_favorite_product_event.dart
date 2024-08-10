part of 'add_favorite_product_bloc.dart';

@immutable
sealed class AddFavoriteProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddFavoriteProduct extends AddFavoriteProductEvent {
  final List<String> productIds;

  AddFavoriteProduct({required this.productIds});

  @override
  List<Object?> get props => [productIds];
}
