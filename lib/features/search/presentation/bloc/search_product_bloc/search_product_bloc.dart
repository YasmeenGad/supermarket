import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/search/data/models/searched_products_model.dart';
import 'package:supermarket/features/search/domain/usecases/search_product_usecase.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProductUsecase searchProductUsecase;
  SearchProductBloc(this.searchProductUsecase) : super(SearchProductInitial()) {
    on<SearchProduct>(_searchProducts);
    on<ClearSearchEvent>((event, emit) {
      emit(SearchProductInitial());
    });
  }

  Future<void> _searchProducts(
      SearchProduct event, Emitter<SearchProductState> emit) async {
    emit(SearchProductLoading());

    final result = await searchProductUsecase(event.query);

    result.fold(
      (failure) => emit(SearchProductError(message: failure)),
      (products) => emit(SearchProductLoaded(products: products)),
    );
  }
}
