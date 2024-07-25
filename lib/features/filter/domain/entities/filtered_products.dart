// product.dart
class FilteredProducts {
  final int quantity;
  final String productName;
  final int price;
  final String productDetail;
  final int rate;
  final String photo;
  final bool bestSelling;

  FilteredProducts({
    required this.quantity,
    required this.productName,
    required this.price,
    required this.productDetail,
    required this.rate,
    required this.photo,
    required this.bestSelling,
  });
}
