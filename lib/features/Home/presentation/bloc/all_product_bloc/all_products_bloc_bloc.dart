import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/Home/domain/entities/product.dart';
import 'package:supermarket/features/Home/domain/usecases/get_all_products_usecase.dart';

part 'all_products_bloc_event.dart';
part 'all_products_bloc_state.dart';

class AllProductsBlocBloc extends Bloc<AllProductsBlocEvent, AllProductsBlocState> {
  final GetProductsUseCase getProductsUseCase;

  AllProductsBlocBloc({required this.getProductsUseCase}) : super(AllProductsBlocInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<AllProductsBlocState> emit) async {
    emit(AllProductsBlocLoading());
    final result = await getProductsUseCase.getAllProducts();

    result.fold(
      (failure) => emit(AllProductsBlocError(failure.message.toString())),
      (products) => emit(AllProductsBlocLoaded(products)),
    );
  }
}
