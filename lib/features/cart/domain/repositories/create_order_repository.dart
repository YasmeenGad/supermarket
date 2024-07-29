import 'package:dartz/dartz.dart';
import 'package:supermarket/features/cart/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Either<String, MyOrder>> createOrder(List<String> productIds);
}
