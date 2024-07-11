import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';
import 'package:supermarket/features/search/domain/usecases/search_product_usecase.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProductUsecase searchProductUsecase;
  SearchProductBloc(this.searchProductUsecase) : super(SearchProductInitial()) {
    on<SearchProductEvent>(_searchProducts);
  }

  Future<void> _searchProducts(
      SearchProductEvent event, Emitter<SearchProductState> emit) async {
    if (event is SearchProduct) {
      emit(SearchProductLoading());

      final result = await searchProductUsecase(event.query);

      result.fold(
        (failure) => emit(SearchProductError(message: failure)),
        (products) => emit(SearchProductLoaded(products: products)),
      );
    }
  }
}
