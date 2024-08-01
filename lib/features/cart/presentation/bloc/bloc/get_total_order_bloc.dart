import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';
import 'package:supermarket/features/cart/domain/usecases/order_usecase.dart';

part 'get_total_order_event.dart';
part 'get_total_order_state.dart';

class GetTotalOrderBloc extends Bloc<GetTotalOrderEvent, GetTotalOrderState> {
  final TotalOderUsecase totalOderUsecase;
  GetTotalOrderBloc({required this.totalOderUsecase}) : super(GetTotalOrderInitial()) {
    on<GetTotalOrder>(_getTotalOrder);
  }

  Future<void> _getTotalOrder(
      GetTotalOrder event, Emitter<GetTotalOrderState> emit) async {
    emit(GetTotalOrderLoading());
    final result = await totalOderUsecase(event.orderId);
    result.fold(
      (l) => emit(GetTotalOrderError(message:l)),
      (r) => emit(GetTotalOrderSuccess(totalOrder: r)),
    );
  }
}
