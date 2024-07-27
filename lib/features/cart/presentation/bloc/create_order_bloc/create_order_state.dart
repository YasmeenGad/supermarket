part of 'create_order_bloc.dart';

sealed class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

final class CreateOrderInitial extends CreateOrderState {}

final class CreateOrderLoading extends CreateOrderState {}

final class CreateOrderSuccess extends CreateOrderState {
  final MyOrder order;
  const CreateOrderSuccess(this.order);

  @override
  List<Object> get props => [order];
}

final class CreateOrderError extends CreateOrderState {
  final String message;
  const CreateOrderError(this.message);

  @override
  List<Object> get props => [message];
}
