import 'package:dartz/dartz.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/entities/delete_order.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';

abstract class OrderRepository {
  Future<Either<String, MyOrder>> createOrder(List<String> productIds);

  Future<Either<String,FetchedOrder>> getOrder();

  Future<Either<String, TotalOrder>> calculateOrderTotals(String orderId);

  Future<Either<String, MyOrder>> updateOrder(String orderId, List<String> productIds);
  Future<Either<String, DeleteOrder>> deleteOrder(List<String> productIds);

}
