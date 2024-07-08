import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Home/data/models/best_selling_products_model.dart';
import 'package:supermarket/features/Home/domain/usecases/get_best_selling_product_usecase.dart';

part 'best_selling_products_event.dart';
part 'best_selling_products_state.dart';

class BestSellingProductsBloc extends Bloc<BestSellingProductsEvent, BestSellingProductsState> {

  final  GetBestSellingProductUsecase bestSellingProductUsecase;
  BestSellingProductsBloc({required this.bestSellingProductUsecase}) : super(BestSellingProductsInitial()) {
    on<GetBestSellingProducts>(_onGetBestSellingProducts);
  }

   Future<void> _onGetBestSellingProducts(GetBestSellingProducts event, Emitter<BestSellingProductsState> emit) async {
    emit(BestSellingProductsInitial());
    final result = await bestSellingProductUsecase();

    result.fold(
      (failure) => emit(BestSellingProductsError(failure.toString())),
      (products) => emit(BestSellingProductsLoaded(products)),
    );
  }
}
