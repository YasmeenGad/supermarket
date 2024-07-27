import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/cart/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(List<String> productIds);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  OrderRemoteDataSourceImpl(
      {required this.authLocalDataSource, required this.client});

  @override
  Future<OrderModel> createOrder(List<String> productIds) async {
    final token = await authLocalDataSource.getCachedToken();
    final response = await client.post(
      Uri.parse('http://$ip:4000/order/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'products': productIds}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      if (json['status']) {
        return OrderModel.fromJson(json['order']);
      } else {
        throw Exception(json['message']);
      }
    } else {
      throw Exception('Failed to create order');
    }
  }
}
