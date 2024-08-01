part of 'get_total_order_bloc.dart';

sealed class GetTotalOrderState extends Equatable {
  const GetTotalOrderState();
  
  @override
  List<Object> get props => [];
}

final class GetTotalOrderInitial extends GetTotalOrderState {}

final class GetTotalOrderLoading extends GetTotalOrderState {}

final class GetTotalOrderSuccess extends GetTotalOrderState {
  final TotalOrder totalOrder;

  const GetTotalOrderSuccess({ required this.totalOrder});

  @override
  List<Object> get props => [totalOrder];
}

final class GetTotalOrderError extends GetTotalOrderState {
  final String message; 

  const GetTotalOrderError({ required this.message});

  @override
  List<Object> get props => [message];
}
