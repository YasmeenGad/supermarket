class FilteredProducts {
  final String id;
  final int quantity;
  final String productName;
  final double price;
  final String productDetail;
  final double rate;
  final String photo;
  final bool bestSelling;

  FilteredProducts({
    required this.id,
    required this.quantity,
    required this.productName,
    required this.price,
    required this.productDetail,
    required this.rate,
    required this.photo,
    required this.bestSelling,
  });
}
