class GetFavoriteProduct {
  final String id;
  final String productName;
  final double price;
  final int quantity;
  final String productDetail;
  final String photo;
  final double rate;

  GetFavoriteProduct({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productDetail,
    required this.photo,
    required this.rate,
  });
}

class GetFavorite {
  final String id;
  final List<GetFavoriteProduct> products;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;

  GetFavorite({
    required this.id,
    required this.products,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });
}

class FavoriteResponse {
  final bool status;
  final String message;
  final List<GetFavorite> fav;

  FavoriteResponse({
    required this.status,
    required this.message,
    required this.fav,
  });
}
