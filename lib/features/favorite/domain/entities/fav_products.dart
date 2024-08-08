class Favorite {
  final String id;
  final List<FavProduct> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  Favorite({
    required this.id,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });
}

class FavProduct {
  final String id;
  final String productName;
  final double price;
  final int stock;
  final int quantity;
  final String productDetail;
  final int rate;
  final String slug;
  final String photo;
  final String categoryName;
  final bool bestSelling;
  final DateTime createdAt;
  final DateTime updatedAt;

  FavProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.stock,
    required this.quantity,
    required this.productDetail,
    required this.rate,
    required this.slug,
    required this.photo,
    required this.categoryName,
    required this.bestSelling,
    required this.createdAt,
    required this.updatedAt,
  });
}
