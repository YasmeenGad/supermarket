import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/usecases/order_usecase.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  final OrderUsecases orderUsecases;

  CreateOrderBloc({required this.orderUsecases}) : super(CreateOrderInitial()) {
    on<CreateOrder>(_onCreateOrder);
  }

  Future<void> _onCreateOrder(
      CreateOrder event, Emitter<CreateOrderState> emit) async {
    emit(CreateOrderLoading());

    final existingOrderResult = await orderUsecases.getOrder();
    await existingOrderResult.fold(
      (error) async {
        // If no existing order, create a new order
        await _createNewOrder(event.productIds, emit);
      },
      (existingOrder) async {
        // If order exists, update the order
        await _updateExistingOrder(existingOrder.id, event.productIds, emit);
      },
    );
  }

  Future<void> _createNewOrder(
      List<String> productIds, Emitter<CreateOrderState> emit) async {
    final result = await orderUsecases.createOrder(productIds);
    result.fold(
      (l) => emit(CreateOrderError(l.message)),
      (r) => emit(CreateOrderSuccess(r)),
    );
  }

  Future<void> _updateExistingOrder(String orderId, List<String> productIds,
      Emitter<CreateOrderState> emit) async {
    final result = await orderUsecases.updateOrder( productIds);
    result.fold(
      (l) => emit(CreateOrderError(l.message)),
      (r) => emit(CreateOrderSuccess(r)),
    );
  }
}
