part of 'update_quantity_bloc.dart';

@immutable
sealed class UpdateQuantityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateQuantity extends UpdateQuantityEvent {
  final int quantity;
  final String id;
  UpdateQuantity({required this.quantity, required this.id});

  @override 
  List<Object?> get props => [quantity, id];
}
