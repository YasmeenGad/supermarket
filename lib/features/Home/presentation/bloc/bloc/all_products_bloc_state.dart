part of 'all_products_bloc_bloc.dart';

sealed class AllProductsBlocState extends Equatable {
  const AllProductsBlocState();
  
  @override
  List<Object> get props => [];
}

final class AllProductsBlocInitial extends AllProductsBlocState {}
final class AllProductsBlocLoading extends AllProductsBlocState {}
final class AllProductsBlocLoaded extends AllProductsBlocState {
  final List<Product> products;

  AllProductsBlocLoaded(this.products);

  @override
  List<Object> get props => [products];
}
final class AllProductsBlocError extends AllProductsBlocState {
  final String message;

  AllProductsBlocError(this.message);

  @override
  List<Object> get props => [message];
}
