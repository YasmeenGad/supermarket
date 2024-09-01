import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Home/domain/entities/best_selling_products.dart';
import 'package:supermarket/features/Home/domain/usecases/get_all_products_usecase.dart';

part 'best_selling_products_event.dart';
part 'best_selling_products_state.dart';

class BestSellingProductsBloc extends Bloc<BestSellingProductsEvent, BestSellingProductsState> {

  final  GetProductsUseCase getProductsUseCase;
  BestSellingProductsBloc({required this.getProductsUseCase}) : super(BestSellingProductsInitial()) {
    on<GetBestSellingProducts>(_onGetBestSellingProducts);
  }

   Future<void> _onGetBestSellingProducts(GetBestSellingProducts event, Emitter<BestSellingProductsState> emit) async {
    emit(BestSellingProductsInitial());
    final result = await getProductsUseCase.getBestSellingProducts();

    result.fold(
      (failure) => emit(BestSellingProductsError(failure.message.toString())),
      (products) => emit(BestSellingProductsLoaded(products)),
    );
  }
}
