part of 'get_total_order_bloc.dart';

sealed class GetTotalOrderEvent extends Equatable {
  const GetTotalOrderEvent();

  @override
  List<Object> get props => [];
}

class GetTotalOrder extends GetTotalOrderEvent {}
