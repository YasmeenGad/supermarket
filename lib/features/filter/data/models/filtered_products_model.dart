import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';

class FilteredProductsModel extends FilteredProducts {
  FilteredProductsModel({
    required final String id,
    required final String productName,
    required final double price,
    required final String productDetail,
    required final double rate,
    required final String photo,
    required final bool bestSelling,
    required final int quantity,
  }) : super(
          id: id,
          quantity: quantity,
          productName: productName,
          price: price,
          productDetail: productDetail,
          rate: rate,
          photo: photo,
          bestSelling: bestSelling,
        );

  factory FilteredProductsModel.fromJson(Map<String, dynamic> json) {
    return FilteredProductsModel(
      id: json['_id'] ?? '',
      quantity: json['quantity'] ?? 0,
      productName: json['productName'] ?? '',
      price: (json['price'] as num).toDouble(), // Handle int or double
      productDetail: json['productDetail'] ?? '',
      rate: (json['rate'] as num).toDouble(), // Handle int or double
      photo: json['photo'] ?? '',
      bestSelling: json['bestSelling'] == 'true' ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'quantity': quantity,
      'productName': productName,
      'price': price,
      'productDetail': productDetail,
      'rate': rate,
      'photo': photo,
      'bestSelling': bestSelling.toString(),
    };
  }
}
