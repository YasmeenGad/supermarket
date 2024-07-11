// entities/product_entity.dart

class SearchedProducts {
  final String id;
  final String productName;
  final bool bestSelling;
  final double price;
  final int stock;
  final int quantity;
  final String productDetail;
  final double rate;
  final String categoryName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String photo;

  SearchedProducts({
    required this.id,
    required this.productName,
    required this.bestSelling,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
  });


}
