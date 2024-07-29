

import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';

class FetchedOrderModel extends FetchedOrder {
  FetchedOrderModel({
    required String id,
    required UserCart user,
    required List<ProductCart> products,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          user: user,
          products: products,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory FetchedOrderModel.fromJson(Map<String, dynamic> json) {
    return FetchedOrderModel(
      id: json['_id'],
      user: UserCart(
        userName: json['userId']['userName'],
        email: json['userId']['email'],
      ),
      products: (json['products'] as List)
          .map((product) => ProductCart(
                productName: product['productName'],
                bestSelling: product['bestSelling'] == 'true',
                price: product['price'].toDouble(),
                quantity: product['quantity'],
                productDetail: product['productDetail'],
                rate: product['rate'],
                categoryName: product['categoryName'],
                photo: product['photo'],
              ))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': {
        'userName': user.userName,
        'email': user.email,
      },
      'products': products
          .map((product) => {
                'productName': product.productName,
                'bestSelling': product.bestSelling ? 'true' : 'false',
                'price': product.price,
                'quantity': product.quantity,
                'productDetail': product.productDetail,
                'rate': product.rate,
                'categoryName': product.categoryName,
                'photo': product.photo,
              })
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
