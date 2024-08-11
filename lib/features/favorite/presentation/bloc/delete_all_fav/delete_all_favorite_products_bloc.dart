import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/favorite/domain/entities/delete_all_favorite_products.dart';
import 'package:supermarket/features/favorite/domain/usecases/favorite_usecase.dart';

part 'delete_all_favorite_products_event.dart';
part 'delete_all_favorite_products_state.dart';

class DeleteAllFavoriteProductsBloc extends Bloc<DeleteAllFavoriteProductsEvent, DeleteAllFavoriteProductsState> {
  final AddFavoriteProductsUseCase deleteUsecase;
  DeleteAllFavoriteProductsBloc(this.deleteUsecase) : super(DeleteAllFavoriteProductsInitial()) {
    on<DeleteAllFavoriteProductsItemEvent>(_deleteAllProducts);
  }

  Future<void> _deleteAllProducts(DeleteAllFavoriteProductsItemEvent event, Emitter<DeleteAllFavoriteProductsState> emit) async {
    emit(DeleteAllFavoriteProductsLoading());
    final deleteAllFavoriteProducts = await deleteUsecase.deleteAllFavoriteProducts();
    deleteAllFavoriteProducts.fold(
      (l) => emit(DeleteAllFavoriteProductsError(l.toString())),
      (r) => emit(DeleteAllFavoriteProductsSuccess(r)),
    );
    
  }
}
