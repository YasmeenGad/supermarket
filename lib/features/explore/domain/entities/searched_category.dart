import 'package:equatable/equatable.dart';

class SearchedCategory extends Equatable {
  final String categoryName;
   final String imageUrl;
  SearchedCategory({required this.imageUrl, required this.categoryName});
  
  @override
  List<Object?> get props => [categoryName, imageUrl];
}