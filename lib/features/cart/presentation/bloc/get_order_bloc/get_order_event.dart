part of 'get_order_bloc.dart';

sealed class GetOrderEvent extends Equatable {
  const GetOrderEvent();

  @override
  List<Object> get props => [];
}
class GetOrder extends GetOrderEvent {}
