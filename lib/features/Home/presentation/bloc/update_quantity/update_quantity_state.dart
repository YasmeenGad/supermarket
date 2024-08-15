part of 'update_quantity_bloc.dart';

@immutable
sealed class UpdateQuantityState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class UpdateQuantityInitial extends UpdateQuantityState {}

final class UpdateQuantityLoading extends UpdateQuantityState {}

final class UpdateQuantityError extends UpdateQuantityState {
  final String message;

  UpdateQuantityError(this.message);

  @override
  List<Object?> get props => [message];
}

final class UpdateQuantitySuccess extends UpdateQuantityState {
  final Product product;

  UpdateQuantitySuccess(this.product);

  @override
  List<Object?> get props => [product];
}
