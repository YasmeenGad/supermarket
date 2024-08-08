part of 'add_favorite_bloc.dart';

sealed class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends AddFavoriteEvent {
final List<String> productIds;
  const AddFavorite(this.productIds); 

  @override
  List<Object> get props => [productIds];
}
