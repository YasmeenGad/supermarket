part of 'best_selling_products_bloc.dart';

sealed class BestSellingProductsEvent extends Equatable {
  const BestSellingProductsEvent();

  @override
  List<Object> get props => [];
}
class GetBestSellingProducts extends BestSellingProductsEvent {}