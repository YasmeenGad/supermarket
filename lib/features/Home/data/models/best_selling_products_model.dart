import 'package:supermarket/features/Home/domain/entities/best_selling_products.dart';

class BestSellingProductsModel extends BestSellingProducts {
  BestSellingProductsModel({
    required String id,
    required String productName,
    required double price,
    required int stock,
    required int quantity,
    required String productDetail,
    required double rate,
    required String createdAt,
    required String updatedAt,
    String? photo,
    required String categoryName,
    required bool bestSelling,
  }) : super(
          id: id,
          productName: productName,
          price: price,
          stock: stock,
          quantity: quantity,
          productDetail: productDetail,
          rate: rate,
          createdAt: createdAt,
          updatedAt: updatedAt,
          photo: photo,
          categoryName: categoryName,
          bestSelling: bestSelling,
        );

  factory BestSellingProductsModel.fromJson(Map<String, dynamic> json) {
    return BestSellingProductsModel(
      id: json['_id'] ?? '',
      productName: json['productName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      quantity: json['quantity'] ?? 0,
      productDetail: json['productDetail'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      photo: json['photo'],
      categoryName: json['categoryName'] ?? '',
      bestSelling: json['bestSelling'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': productName,
      'price': price,
      'stock': stock,
      'quantity': quantity,
      'productDetail': productDetail,
      'rate': rate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'photo': photo,
      'categoryName': categoryName,
      'bestSelling': bestSelling.toString(),
    };
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, productName: $productName, price: $price, stock: $stock, quantity: $quantity, productDetail: $productDetail, rate: $rate, createdAt: $createdAt, updatedAt: $updatedAt, photo: $photo, categoryName: $categoryName, bestSelling: $bestSelling)';
  }
}
