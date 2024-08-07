// lib/features/favorites/data/models/favorites_model.dart

import 'package:equatable/equatable.dart';

class FavoritesModel extends Equatable {
  final bool status;
  final String message;
  final FavoritesData favorites;

  const FavoritesModel({
    required this.status,
    required this.message,
    required this.favorites,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      status: json['status'],
      message: json['message'],
      favorites: FavoritesData.fromJson(json['favorites']),
    );
  }

  @override
  List<Object> get props => [status, message, favorites];
}







