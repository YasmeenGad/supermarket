import 'package:dartz/dartz.dart';
import 'package:supermarket/core/error/failure.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/entities/delete_order.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';
import 'package:supermarket/features/cart/domain/entities/get_total_order.dart';

abstract class OrderRepository {
  Future<Either<Failure, MyOrder>> createOrder(List<String> productIds);

  Future<Either<Failure,FetchedOrder>> getOrder();

  Future<Either<Failure, TotalOrder>> calculateOrderTotals();

  Future<Either<Failure, MyOrder>> updateOrder(List<String> productIds);
  Future<Either<Failure, DeleteOrder>> deleteOrder(List<String> productIds);

}
