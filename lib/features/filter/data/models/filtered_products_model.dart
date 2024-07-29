import 'package:supermarket/features/filter/domain/entities/filtered_products.dart';

class FilteredProductsModel extends FilteredProducts {
  

  FilteredProductsModel({
    required final String id,
    required final String productName,
    required final int price,
    required final String productDetail,
    required final int rate,
    required final String photo,
    required final bool bestSelling,
    required final int quantity,
  }): super(
    id: id,
    quantity: quantity,
    productName: productName,
    price: price,
    productDetail: productDetail,
    rate: rate,
    photo: photo,
    bestSelling: bestSelling
  );

  factory FilteredProductsModel.fromJson(Map<String, dynamic> json) {
    return FilteredProductsModel(
      id: json['_id'] ?? '',
      quantity: json['quantity'] ?? 0,
      productName: json['productName'] ?? '',
      price: json['price']?? 0.0,
      productDetail: json['productDetail']?? '',
      rate: json['rate']?? 0.0,
      photo: json['photo']?? '',
      bestSelling: json['bestSelling'] == 'true'? true : false,
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