import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_model.dart';

abstract class OrderLocalDataSource {
  Future<void> cacheOrder(OrderModel orderToCache);
  Future<OrderModel?> getLastOrder();
}

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  static const CACHED_ORDER = 'CACHED_ORDER';

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
}
