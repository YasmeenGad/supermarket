import 'package:dartz/dartz.dart';
import 'package:supermarket/features/cart/domain/entities/create_order_entity.dart';
import 'package:supermarket/features/cart/domain/entities/fetch_order_entities.dart';

abstract class OrderRepository {
  Future<Either<String, MyOrder>> createOrder(List<String> productIds);

  Future<Either<String,FetchedOrder>> getOrder();
}
