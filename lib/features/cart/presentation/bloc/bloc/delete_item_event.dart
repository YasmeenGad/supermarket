part of 'delete_item_bloc.dart';

@immutable
sealed class DeleteItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteItem extends DeleteItemEvent {
  final List<String> productId;
  DeleteItem({required this.productId});

  @override
  List<Object?> get props => [productId];
}
