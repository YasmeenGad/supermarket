import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket/features/cart/data/models/fetch_order_model.dart';
import '../models/order_model.dart';

abstract class OrderLocalDataSource {
  Future<void> cacheOrder(OrderModel orderToCache);
  Future<OrderModel?> getLastOrder();
  Future<void> cacheFetchedOrder(List<FetchedOrderModel> fetchedOrder);
  Future<List<FetchedOrderModel>> getLastFetchedOrder();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  static const CACHED_ORDER = 'CACHED_ORDER';
  static const CACHED_FETCHED_ORDER = 'CACHED_FETCHED_ORDER';

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
  Future<void> cacheFetchedOrder(List<FetchedOrderModel> fetchedOrder) async {
    final productsJson = fetchedOrder.map((product) => product.toJson()).toList();
    await sharedPreferences.setString(
        CACHED_FETCHED_ORDER, json.encode(productsJson));
  
  }

  @override
  Future<List<FetchedOrderModel>> getLastFetchedOrder() async {
    final jsonString =
        await sharedPreferences.getString(CACHED_FETCHED_ORDER);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => FetchedOrderModel.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }
}
