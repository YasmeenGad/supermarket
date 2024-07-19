import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';
import 'package:supermarket/features/filter/domain/usecases/filtered_products_usecase.dart';

part 'filtered_products_event.dart';
part 'filtered_products_state.dart';

class FilteredProductsBloc
    extends Bloc<FilteredProductsEvent, FilteredProductsState> {
  final FilteredProductsUsecase filteredProductsUsecase;
  FilteredProductsBloc({required this.filteredProductsUsecase})
      : super(FilteredProductsInitial()) {
    on<GetProductsByCategoryEvent>(_getProductsByCategory);
  }

  Future<void> _getProductsByCategory(GetProductsByCategoryEvent event,
      Emitter<FilteredProductsState> emit) async {
    emit(FilteredProductsLoading());
    final result = await filteredProductsUsecase(event.categoryName);
    result.fold(
      (failure) => emit(FilteredProductsError(message: failure.toString())),
      (filteredProducts) =>
          emit(FilteredProductsLoaded(products: filteredProducts)),
    );
  }
}
