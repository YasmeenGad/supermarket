import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/cart/data/models/fetch_order_model.dart';
import 'package:supermarket/features/cart/data/models/get_total_order_model.dart';
import '../models/order_model.dart';

abstract class OrderLocalDataSource {
  Future<void> cacheOrder(OrderModel orderToCache);
  Future<OrderModel?> getLastOrder();
  Future<void> cacheFetchedOrder(FetchedOrderModel fetchedOrder);
  Future<FetchedOrderModel?> getLastFetchedOrder();
  Future<void> cacheTotalOrder(TotalOrderModel totalOrderToCache);
  Future<TotalOrderModel?> getTotalOrder();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  static const CACHED_ORDER = 'CACHED_ORDER';
  static const CACHED_FETCHED_ORDER = 'CACHED_FETCHED_ORDER';
  static const CACHED_TOTAL_ORDER = 'CACHED_TOTAL_ORDER';

  @override
  Future<void> cacheOrder(OrderModel orderToCache) {
    return sharedPreferences.setString(
      CACHED_ORDER,
      json.encode(orderToCache.toJson()),
    );
  }

  @override
  Future<OrderModel?> getLastOrder() {
    final jsonString = sharedPreferences.getString(CACHED_ORDER);
    if (jsonString != null) {
      return Future.value(OrderModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<void> cacheFetchedOrder(FetchedOrderModel fetchedOrder) async {
    await sharedPreferences.setString(
        CACHED_FETCHED_ORDER, json.encode(fetchedOrder.toJson()));
  }

  @override
  Future<FetchedOrderModel?> getLastFetchedOrder() async {
    final jsonString = await sharedPreferences.getString(CACHED_FETCHED_ORDER);
    if (jsonString != null) {
      return Future.value(FetchedOrderModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(null);
    }
  }
  
  @override
  Future<void> cacheTotalOrder(TotalOrderModel totalOrderToCache) {
    return sharedPreferences.setString(
      CACHED_TOTAL_ORDER,
      json.encode(totalOrderToCache.toJson()),
    );
  }
  
  @override
  Future<TotalOrderModel?> getTotalOrder() {
    final jsonString = sharedPreferences.getString(CACHED_TOTAL_ORDER);
    if (jsonString != null) {
      return Future.value(TotalOrderModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(null);
    }
  }
}
