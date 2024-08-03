import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supermarket/core/constants/ip.dart';
import 'package:supermarket/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:supermarket/features/cart/data/models/fetch_order_model.dart';
import 'package:supermarket/features/cart/data/models/get_total_order_model.dart';
import 'package:supermarket/features/cart/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(List<String> productIds);
  Future<FetchedOrderModel> getOrder();
  Future<TotalOrderModel> getOrderTotals(String orderId);
  Future<OrderModel> updateOrder(String orderId, List<String> productIds);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  OrderRemoteDataSourceImpl(
      {required this.authLocalDataSource, required this.client});

  @override
  Future<OrderModel> createOrder(List<String> productIds) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token;
    print(token);
    final response = await client.post(
      Uri.parse('http://$ip:4000/order/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $cachedToken',
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
      print("1");
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  @override
  Future<FetchedOrderModel> getOrder() async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token;
    final response = await client.get(
      Uri.parse('http://$ip:4000/order/get'),
      headers: {
        'Authorization': 'Bearer $cachedToken',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data['status']) {
        return FetchedOrderModel.fromJson(data['message']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  @override
  Future<TotalOrderModel> getOrderTotals(String orderId) async {
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token;
    final response = await client.get(
      Uri.parse('http://$ip:4000/order/total/$orderId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $cachedToken',
      },
    );

    if (response.statusCode == 200) {
      return TotalOrderModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to calculate order totals');
    }
  }
  
  @override
  Future<OrderModel> updateOrder(String orderId, List<String> productIds) async{
    final token = await authLocalDataSource.getCachedLoginResponse();
    final cachedToken = token?.token;
    final response = await client.patch(
      Uri.parse('http://$ip:4000/order/add/$orderId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $cachedToken',
      },
      body: jsonEncode({'products': productIds}),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status']) {
        return OrderModel.fromJson(json['order']);
      } else {
        throw Exception(json['message']);
      }
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
