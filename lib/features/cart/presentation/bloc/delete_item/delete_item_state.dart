part of 'delete_item_bloc.dart';

@immutable
sealed class DeleteItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DeleteItemInitial extends DeleteItemState {}

final class DeleteItemLoading extends DeleteItemState {}

final class DeleteItemSuccess extends DeleteItemState {
  final DeleteOrder deleteOrder;
  DeleteItemSuccess({required this.deleteOrder});

  @override
  List<Object?> get props => [deleteOrder];
}

final class DeleteItemError extends DeleteItemState {
  final String message;
  DeleteItemError({required this.message});
  @override
  List<Object?> get props => [message];
}
