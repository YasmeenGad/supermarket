// product_model.dart
class FilteredProductsModel {
  final String productName;
  final int price;
  final String productDetail;
  final int rate;
  final String photo;
  final bool bestSelling;

  FilteredProductsModel({
    required this.productName,
    required this.price,
    required this.productDetail,
    required this.rate,
    required this.photo,
    required this.bestSelling,
  });

  factory FilteredProductsModel.fromJson(Map<String, dynamic> json) {
    return FilteredProductsModel(
      productName: json['productName'],
      price: json['price'],
      productDetail: json['productDetail'],
      rate: json['rate'],
      photo: json['photo'],
      bestSelling: json['bestSelling'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'price': price,
      'productDetail': productDetail,
      'rate': rate,
      'photo': photo,
      'bestSelling': bestSelling.toString(),
    };
  }
}
