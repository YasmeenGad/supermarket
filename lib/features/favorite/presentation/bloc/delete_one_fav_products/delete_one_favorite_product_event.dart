part of 'delete_one_favorite_product_bloc.dart';

@immutable
sealed class DeleteOneFavoriteProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteOneFavoriteProductItem extends DeleteOneFavoriteProductEvent {
  final List<String> id;
  DeleteOneFavoriteProductItem({required this.id});

  @override
  List<Object?> get props => [id];
}
