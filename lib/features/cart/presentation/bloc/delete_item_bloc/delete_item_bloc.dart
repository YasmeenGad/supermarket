

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supermarket/features/cart/domain/entities/delete_order.dart';
import 'package:supermarket/features/cart/domain/usecases/order_usecase.dart';

part 'delete_item_event.dart';
part 'delete_item_state.dart';

class DeleteItemBloc extends Bloc<DeleteItemEvent, DeleteItemState> {
  final OrderUsecases orderUsecases;
  DeleteItemBloc(this.orderUsecases) : super(DeleteItemInitial()) {
    on<DeleteItem>(_deleteItem);
  }

  Future<void> _deleteItem(
      DeleteItem event, Emitter<DeleteItemState> emit) async {
    emit(DeleteItemLoading());
    final result = await orderUsecases.deleteOrder(event.productId);
    result.fold(
      (failure) => emit(DeleteItemError(message: failure.toString())),
      (success) => emit(DeleteItemSuccess(deleteOrder: success)),
    );
  }
}

