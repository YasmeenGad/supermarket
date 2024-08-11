part of 'delete_one_favorite_product_bloc.dart';

@immutable
sealed class DeleteOneFavoriteProductState extends Equatable {

  @override
  List<Object?> get props => [];
}

final class DeleteOneFavoriteProductInitial extends DeleteOneFavoriteProductState {}

final class DeleteOneFavoriteProductLoading extends DeleteOneFavoriteProductState {}  

final class DeleteOneFavoriteProductSuccess extends DeleteOneFavoriteProductState {
  final DeleteOneFavoriteProduct deleteOneFavoriteProduct;
  DeleteOneFavoriteProductSuccess({required this.deleteOneFavoriteProduct});

  @override
  List<Object?> get props => [deleteOneFavoriteProduct];
}

final class DeleteOneFavoriteProductError extends DeleteOneFavoriteProductState {
  final String message;
  DeleteOneFavoriteProductError({required this.message}); 

  @override
  List<Object?> get props => [message];
}
