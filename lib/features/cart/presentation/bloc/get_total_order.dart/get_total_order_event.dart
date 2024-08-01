part of 'get_total_order_bloc.dart';

sealed class GetTotalOrderEvent extends Equatable {
  const GetTotalOrderEvent();

  @override
  List<Object> get props => [];
}

class GetTotalOrder extends GetTotalOrderEvent {
  final String orderId;
  const GetTotalOrder({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
