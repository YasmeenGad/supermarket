part of 'get_order_bloc.dart';

sealed class GetOrderState extends Equatable {
  const GetOrderState();

  @override
  List<Object> get props => [];
}

final class GetOrderInitial extends GetOrderState {}

final class GetOrderLoading extends GetOrderState {}

final class GetOrderSuccess extends GetOrderState {
  final FetchedOrder orders;
  const GetOrderSuccess(this.orders);

  @override
  List<Object> get props => [orders];
}

final class GetOrderError extends GetOrderState {
  final String message;
  const GetOrderError(this.message);
  @override
  List<Object> get props => [message];
}
