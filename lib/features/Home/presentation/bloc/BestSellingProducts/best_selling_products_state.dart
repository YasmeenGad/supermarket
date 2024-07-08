part of 'best_selling_products_bloc.dart';

abstract class BestSellingProductsState extends Equatable {
  const BestSellingProductsState();
  
  @override
  List<Object> get props => [];
}

final class BestSellingProductsInitial extends BestSellingProductsState {}
final class BestSellingProductsLoading extends BestSellingProductsState {}
final class BestSellingProductsLoaded extends BestSellingProductsState {
  final List<BestSellingProductsModel> products;

  BestSellingProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}
final class BestSellingProductsError extends BestSellingProductsState {
  final String message;

  BestSellingProductsError(this.message);

  @override
  List<Object> get props => [message];
}
