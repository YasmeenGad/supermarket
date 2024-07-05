part of 'all_products_bloc_bloc.dart';

sealed class AllProductsBlocEvent extends Equatable {
  const AllProductsBlocEvent();

  @override
  List<Object> get props => [];
}
class FetchProducts extends AllProductsBlocEvent {}
