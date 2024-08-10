
import 'package:equatable/equatable.dart';

class AddFavorite extends Equatable {
  final List<String> products;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AddFavorite({
    required this.products,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [products, id, createdAt, updatedAt];
}
