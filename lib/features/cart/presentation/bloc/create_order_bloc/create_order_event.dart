part of 'create_order_bloc.dart';

sealed class CreateOrderEvent extends Equatable {
  const CreateOrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrder extends CreateOrderEvent {
  final List<String> productIds;

  const CreateOrder(this.productIds);

  @override
  List<Object> get props => [productIds];
}

class UpdateOrder extends CreateOrderEvent {
  final List<String> productIds;

  UpdateOrder( this.productIds);

  @override
  List<Object> get props => [productIds];
}
