import 'package:equatable/equatable.dart';

class Categories extends Equatable{
  final String categoryName;

 const Categories({required this.categoryName});
  
  @override
  List<Object?> get props => [categoryName];
}