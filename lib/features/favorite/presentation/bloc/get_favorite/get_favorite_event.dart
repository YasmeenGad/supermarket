part of 'get_favorite_bloc.dart';

sealed class GetFavoriteEvent extends Equatable {
  const GetFavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteProducts extends GetFavoriteEvent {
  final String id;
  const GetFavoriteProducts(this.id);
}
