import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';

class FetchedOrderModel extends FetchedOrder {
  FetchedOrderModel({
    required String id,
    required String user,
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
      id: json['_id'] ?? '',
      user: json['userId'] ?? '',
      products: (json['products'] as List)
          .map((product) => ProductCart(
                id: product['_id'] ?? '',
                productName: product['productName'] ?? '',
                bestSelling: product['bestSelling'] == 'true',
                price: (product['price'] as num?)?.toDouble() ?? 0.0,
                quantity: (product['quantity'] as num?)?.toInt() ?? 0,
                productDetail: product['productDetail'] ?? '',
                rate: (product['rate'] as num?)?.toDouble() ?? 0.0,
                categoryName: product['categoryName'] ?? '',
                photo: product['photo'] ?? '',
              ))
          .toList(),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': user,
      'products': products
          .map((product) => {
                '_id': product.id,
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
  FetchedOrderModel copyWith({
    String? id,
    UserCart? user,
    List<ProductCart>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FetchedOrderModel(
      id: id ?? this.id,
      user: user ?? this.user,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
